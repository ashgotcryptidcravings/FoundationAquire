#!/usr/bin/env swift
import Foundation
import SceneKit
import Metal
import AppKit

// Simple script to render thumbnails for USDZ/scene files using SceneKit + Metal.
// Usage: swift tools/generate_thumbnails.swift /path/to/assets /path/to/output [size]

func usage() -> Never {
    let exe = URL(fileURLWithPath: CommandLine.arguments[0]).lastPathComponent
    print("Usage: \(exe) <assets-folder> <output-folder> [size]")
    exit(1)
}

guard CommandLine.argc >= 3 else { usage() }
let assetsFolder = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
let outputFolder = URL(fileURLWithPath: CommandLine.arguments[2], isDirectory: true)
let sizeArg = CommandLine.argc >= 4 ? Int(CommandLine.arguments[3]) ?? 512 : 512
let size = CGSize(width: sizeArg, height: sizeArg)

let fm = FileManager.default
if !fm.fileExists(atPath: assetsFolder.path) { print("Assets folder not found: \(assetsFolder.path)"); exit(1) }
try? fm.createDirectory(at: outputFolder, withIntermediateDirectories: true)

let exts = ["usdz", "scn", "dae"]
let device = MTLCreateSystemDefaultDevice()
guard let mtlDevice = device else { print("No Metal device available."); exit(1) }

func findModels(in folder: URL) -> [URL] {
    let enumerator = fm.enumerator(at: folder, includingPropertiesForKeys: nil)
    var results: [URL] = []
    while let f = enumerator?.nextObject() as? URL {
        if exts.contains(f.pathExtension.lowercased()) {
            results.append(f)
        }
    }
    return results
}

let models = findModels(in: assetsFolder)
if models.isEmpty {
    print("No model files found in \(assetsFolder.path)")
    exit(0)
}

print("Found \(models.count) models; rendering thumbnails to \(outputFolder.path)")

for modelURL in models {
    autoreleasepool {
        let name = modelURL.deletingPathExtension().lastPathComponent
        print("Rendering \(name) ...")
        var scene: SCNScene?
        if let s = try? SCNScene(url: modelURL, options: nil) {
            scene = s
        } else if let s = SCNScene(named: modelURL.lastPathComponent) {
            scene = s
        }

        guard let sceneUnwrapped = scene else {
            print("  Failed to load scene for \(modelURL.path)")
            return
        }

        // Create a renderer and snapshot
        let renderer = SCNRenderer(device: mtlDevice, options: nil)
        renderer.scene = sceneUnwrapped

        // Provide a default camera if scene doesn't have one
        if renderer.pointOfView == nil {
            let cam = SCNNode()
            cam.camera = SCNCamera()
            cam.camera?.fieldOfView = 45
            cam.position = SCNVector3(0, 0, 3)
            renderer.pointOfView = cam
        }

        // snapshot
        let nsImage = renderer.snapshot(atTime: 0.0, with: size, antialiasingMode: .multisampling4X)

        // Write PNG
        if let tiff = nsImage.tiffRepresentation,
           let rep = NSBitmapImageRep(data: tiff),
           let png = rep.representation(using: .png, properties: [:]) {
            let outURL = outputFolder.appendingPathComponent("\(name)_thumb.png")
            try? png.write(to: outURL)
            print("  -> \(outURL.path)")
        } else {
            print("  Failed to write thumbnail for \(name)")
        }
    }
}

print("Done.")
