//
//  PatchNotes.swift
//  Aquire
//

import Foundation

struct PatchRelease: Identifiable, Hashable {
    let id = UUID()
    let version: String
    let date: String
    let highlights: [String]
}
