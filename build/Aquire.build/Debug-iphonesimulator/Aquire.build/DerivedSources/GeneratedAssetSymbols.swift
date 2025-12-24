import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

    /// The "AccentColor" asset catalog color resource.
    static let accent = DeveloperToolsSupport.ColorResource(name: "AccentColor", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "AppIcon-iOS-ClearDark-1024x1024" asset catalog image resource.
    static let appIconIOSClearDark1024X1024 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-1024x1024", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-128x128" asset catalog image resource.
    static let appIconIOSClearDark128X128 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-128x128", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-16x16" asset catalog image resource.
    static let appIconIOSClearDark16X16 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-16x16", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-20x20" asset catalog image resource.
    static let appIconIOSClearDark20X20 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-20x20", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-256x256" asset catalog image resource.
    static let appIconIOSClearDark256X256 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-256x256", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-29x29" asset catalog image resource.
    static let appIconIOSClearDark29X29 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-29x29", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-32x32" asset catalog image resource.
    static let appIconIOSClearDark32X32 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-32x32", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-38x38" asset catalog image resource.
    static let appIconIOSClearDark38X38 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-38x38", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-40x40" asset catalog image resource.
    static let appIconIOSClearDark40X40 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-40x40", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-512x512" asset catalog image resource.
    static let appIconIOSClearDark512X512 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-512x512", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-60x60" asset catalog image resource.
    static let appIconIOSClearDark60X60 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-60x60", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-64x64" asset catalog image resource.
    static let appIconIOSClearDark64X64 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-64x64", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-68x68" asset catalog image resource.
    static let appIconIOSClearDark68X68 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-68x68", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-76x76" asset catalog image resource.
    static let appIconIOSClearDark76X76 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-76x76", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearDark-83.5x83.5" asset catalog image resource.
    static let appIconIOSClearDark835X835 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearDark-83.5x83.5", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-1024x1024" asset catalog image resource.
    static let appIconIOSClearLight1024X1024 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-1024x1024", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-128x128" asset catalog image resource.
    static let appIconIOSClearLight128X128 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-128x128", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-16x16" asset catalog image resource.
    static let appIconIOSClearLight16X16 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-16x16", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-20x20" asset catalog image resource.
    static let appIconIOSClearLight20X20 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-20x20", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-256x256" asset catalog image resource.
    static let appIconIOSClearLight256X256 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-256x256", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-29x29" asset catalog image resource.
    static let appIconIOSClearLight29X29 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-29x29", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-32x32" asset catalog image resource.
    static let appIconIOSClearLight32X32 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-32x32", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-38x38" asset catalog image resource.
    static let appIconIOSClearLight38X38 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-38x38", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-40x40" asset catalog image resource.
    static let appIconIOSClearLight40X40 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-40x40", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-512x512" asset catalog image resource.
    static let appIconIOSClearLight512X512 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-512x512", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-60x60" asset catalog image resource.
    static let appIconIOSClearLight60X60 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-60x60", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-64x64" asset catalog image resource.
    static let appIconIOSClearLight64X64 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-64x64", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-68x68" asset catalog image resource.
    static let appIconIOSClearLight68X68 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-68x68", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-76x76" asset catalog image resource.
    static let appIconIOSClearLight76X76 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-76x76", bundle: resourceBundle)

    /// The "AppIcon-iOS-ClearLight-83.5x83.5" asset catalog image resource.
    static let appIconIOSClearLight835X835 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-ClearLight-83.5x83.5", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-1024x1024" asset catalog image resource.
    static let appIconIOSDark1024X1024 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-1024x1024", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-128x128" asset catalog image resource.
    static let appIconIOSDark128X128 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-128x128", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-16x16" asset catalog image resource.
    static let appIconIOSDark16X16 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-16x16", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-20x20" asset catalog image resource.
    static let appIconIOSDark20X20 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-20x20", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-256x256" asset catalog image resource.
    static let appIconIOSDark256X256 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-256x256", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-29x29" asset catalog image resource.
    static let appIconIOSDark29X29 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-29x29", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-32x32" asset catalog image resource.
    static let appIconIOSDark32X32 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-32x32", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-38x38" asset catalog image resource.
    static let appIconIOSDark38X38 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-38x38", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-40x40" asset catalog image resource.
    static let appIconIOSDark40X40 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-40x40", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-512x512" asset catalog image resource.
    static let appIconIOSDark512X512 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-512x512", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-60x60" asset catalog image resource.
    static let appIconIOSDark60X60 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-60x60", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-64x64" asset catalog image resource.
    static let appIconIOSDark64X64 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-64x64", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-68x68" asset catalog image resource.
    static let appIconIOSDark68X68 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-68x68", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-76x76" asset catalog image resource.
    static let appIconIOSDark76X76 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-76x76", bundle: resourceBundle)

    /// The "AppIcon-iOS-Dark-83.5x83.5" asset catalog image resource.
    static let appIconIOSDark835X835 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Dark-83.5x83.5", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-1024x1024" asset catalog image resource.
    static let appIconIOSDefault1024X1024 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-1024x1024", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-128x128" asset catalog image resource.
    static let appIconIOSDefault128X128 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-128x128", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-16x16" asset catalog image resource.
    static let appIconIOSDefault16X16 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-16x16", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-20x20" asset catalog image resource.
    static let appIconIOSDefault20X20 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-20x20", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-256x256" asset catalog image resource.
    static let appIconIOSDefault256X256 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-256x256", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-29x29" asset catalog image resource.
    static let appIconIOSDefault29X29 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-29x29", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-32x32" asset catalog image resource.
    static let appIconIOSDefault32X32 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-32x32", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-38x38" asset catalog image resource.
    static let appIconIOSDefault38X38 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-38x38", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-40x40" asset catalog image resource.
    static let appIconIOSDefault40X40 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-40x40", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-512x512" asset catalog image resource.
    static let appIconIOSDefault512X512 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-512x512", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-60x60" asset catalog image resource.
    static let appIconIOSDefault60X60 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-60x60", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-64x64" asset catalog image resource.
    static let appIconIOSDefault64X64 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-64x64", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-68x68" asset catalog image resource.
    static let appIconIOSDefault68X68 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-68x68", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-76x76" asset catalog image resource.
    static let appIconIOSDefault76X76 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-76x76", bundle: resourceBundle)

    /// The "AppIcon-iOS-Default-83.5x83.5" asset catalog image resource.
    static let appIconIOSDefault835X835 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-Default-83.5x83.5", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-1024x1024" asset catalog image resource.
    static let appIconIOSTintedDark1024X1024 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-1024x1024", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-128x128" asset catalog image resource.
    static let appIconIOSTintedDark128X128 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-128x128", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-16x16" asset catalog image resource.
    static let appIconIOSTintedDark16X16 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-16x16", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-20x20" asset catalog image resource.
    static let appIconIOSTintedDark20X20 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-20x20", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-256x256" asset catalog image resource.
    static let appIconIOSTintedDark256X256 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-256x256", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-29x29" asset catalog image resource.
    static let appIconIOSTintedDark29X29 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-29x29", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-32x32" asset catalog image resource.
    static let appIconIOSTintedDark32X32 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-32x32", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-38x38" asset catalog image resource.
    static let appIconIOSTintedDark38X38 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-38x38", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-40x40" asset catalog image resource.
    static let appIconIOSTintedDark40X40 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-40x40", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-512x512" asset catalog image resource.
    static let appIconIOSTintedDark512X512 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-512x512", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-60x60" asset catalog image resource.
    static let appIconIOSTintedDark60X60 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-60x60", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-64x64" asset catalog image resource.
    static let appIconIOSTintedDark64X64 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-64x64", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-68x68" asset catalog image resource.
    static let appIconIOSTintedDark68X68 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-68x68", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-76x76" asset catalog image resource.
    static let appIconIOSTintedDark76X76 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-76x76", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedDark-83.5x83.5" asset catalog image resource.
    static let appIconIOSTintedDark835X835 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedDark-83.5x83.5", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-1024x1024" asset catalog image resource.
    static let appIconIOSTintedLight1024X1024 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-1024x1024", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-128x128" asset catalog image resource.
    static let appIconIOSTintedLight128X128 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-128x128", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-16x16" asset catalog image resource.
    static let appIconIOSTintedLight16X16 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-16x16", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-20x20" asset catalog image resource.
    static let appIconIOSTintedLight20X20 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-20x20", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-256x256" asset catalog image resource.
    static let appIconIOSTintedLight256X256 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-256x256", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-29x29" asset catalog image resource.
    static let appIconIOSTintedLight29X29 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-29x29", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-32x32" asset catalog image resource.
    static let appIconIOSTintedLight32X32 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-32x32", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-38x38" asset catalog image resource.
    static let appIconIOSTintedLight38X38 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-38x38", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-40x40" asset catalog image resource.
    static let appIconIOSTintedLight40X40 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-40x40", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-512x512" asset catalog image resource.
    static let appIconIOSTintedLight512X512 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-512x512", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-60x60" asset catalog image resource.
    static let appIconIOSTintedLight60X60 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-60x60", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-64x64" asset catalog image resource.
    static let appIconIOSTintedLight64X64 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-64x64", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-68x68" asset catalog image resource.
    static let appIconIOSTintedLight68X68 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-68x68", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-76x76" asset catalog image resource.
    static let appIconIOSTintedLight76X76 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-76x76", bundle: resourceBundle)

    /// The "AppIcon-iOS-TintedLight-83.5x83.5" asset catalog image resource.
    static let appIconIOSTintedLight835X835 = DeveloperToolsSupport.ImageResource(name: "AppIcon-iOS-TintedLight-83.5x83.5", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-1088x1088" asset catalog image resource.
    static let appIconWatchOSDefault1088X1088 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-1088x1088", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-108x108" asset catalog image resource.
    static let appIconWatchOSDefault108X108 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-108x108", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-117x117" asset catalog image resource.
    static let appIconWatchOSDefault117X117 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-117x117", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-129x129" asset catalog image resource.
    static let appIconWatchOSDefault129X129 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-129x129", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-22x22" asset catalog image resource.
    static let appIconWatchOSDefault22X22 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-22x22", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-24x24" asset catalog image resource.
    static let appIconWatchOSDefault24X24 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-24x24", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-27.5x27.5" asset catalog image resource.
    static let appIconWatchOSDefault275X275 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-27.5x27.5", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-29x29" asset catalog image resource.
    static let appIconWatchOSDefault29X29 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-29x29", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-30x30" asset catalog image resource.
    static let appIconWatchOSDefault30X30 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-30x30", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-32x32" asset catalog image resource.
    static let appIconWatchOSDefault32X32 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-32x32", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-33x33" asset catalog image resource.
    static let appIconWatchOSDefault33X33 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-33x33", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-40x40" asset catalog image resource.
    static let appIconWatchOSDefault40X40 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-40x40", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-43.5x43.5" asset catalog image resource.
    static let appIconWatchOSDefault435X435 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-43.5x43.5", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-44x44" asset catalog image resource.
    static let appIconWatchOSDefault44X44 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-44x44", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-46x46" asset catalog image resource.
    static let appIconWatchOSDefault46X46 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-46x46", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-50x50" asset catalog image resource.
    static let appIconWatchOSDefault50X50 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-50x50", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-51x51" asset catalog image resource.
    static let appIconWatchOSDefault51X51 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-51x51", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-54x54" asset catalog image resource.
    static let appIconWatchOSDefault54X54 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-54x54", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-86x86" asset catalog image resource.
    static let appIconWatchOSDefault86X86 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-86x86", bundle: resourceBundle)

    /// The "AppIcon-watchOS-Default-98x98" asset catalog image resource.
    static let appIconWatchOSDefault98X98 = DeveloperToolsSupport.ImageResource(name: "AppIcon-watchOS-Default-98x98", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "AccentColor" asset catalog color.
    static var accent: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .accent)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "AccentColor" asset catalog color.
    static var accent: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .accent)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    /// The "AccentColor" asset catalog color.
    static var accent: SwiftUI.Color { .init(.accent) }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "AccentColor" asset catalog color.
    static var accent: SwiftUI.Color { .init(.accent) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "AppIcon-iOS-ClearDark-1024x1024" asset catalog image.
    static var appIconIOSClearDark1024X1024: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-128x128" asset catalog image.
    static var appIconIOSClearDark128X128: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-16x16" asset catalog image.
    static var appIconIOSClearDark16X16: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-20x20" asset catalog image.
    static var appIconIOSClearDark20X20: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-256x256" asset catalog image.
    static var appIconIOSClearDark256X256: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-29x29" asset catalog image.
    static var appIconIOSClearDark29X29: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-32x32" asset catalog image.
    static var appIconIOSClearDark32X32: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-38x38" asset catalog image.
    static var appIconIOSClearDark38X38: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-40x40" asset catalog image.
    static var appIconIOSClearDark40X40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-512x512" asset catalog image.
    static var appIconIOSClearDark512X512: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-60x60" asset catalog image.
    static var appIconIOSClearDark60X60: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-64x64" asset catalog image.
    static var appIconIOSClearDark64X64: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-68x68" asset catalog image.
    static var appIconIOSClearDark68X68: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-76x76" asset catalog image.
    static var appIconIOSClearDark76X76: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-83.5x83.5" asset catalog image.
    static var appIconIOSClearDark835X835: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearDark835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-1024x1024" asset catalog image.
    static var appIconIOSClearLight1024X1024: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-128x128" asset catalog image.
    static var appIconIOSClearLight128X128: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-16x16" asset catalog image.
    static var appIconIOSClearLight16X16: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-20x20" asset catalog image.
    static var appIconIOSClearLight20X20: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-256x256" asset catalog image.
    static var appIconIOSClearLight256X256: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-29x29" asset catalog image.
    static var appIconIOSClearLight29X29: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-32x32" asset catalog image.
    static var appIconIOSClearLight32X32: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-38x38" asset catalog image.
    static var appIconIOSClearLight38X38: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-40x40" asset catalog image.
    static var appIconIOSClearLight40X40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-512x512" asset catalog image.
    static var appIconIOSClearLight512X512: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-60x60" asset catalog image.
    static var appIconIOSClearLight60X60: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-64x64" asset catalog image.
    static var appIconIOSClearLight64X64: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-68x68" asset catalog image.
    static var appIconIOSClearLight68X68: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-76x76" asset catalog image.
    static var appIconIOSClearLight76X76: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-83.5x83.5" asset catalog image.
    static var appIconIOSClearLight835X835: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSClearLight835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-1024x1024" asset catalog image.
    static var appIconIOSDark1024X1024: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-128x128" asset catalog image.
    static var appIconIOSDark128X128: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-16x16" asset catalog image.
    static var appIconIOSDark16X16: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-20x20" asset catalog image.
    static var appIconIOSDark20X20: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-256x256" asset catalog image.
    static var appIconIOSDark256X256: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-29x29" asset catalog image.
    static var appIconIOSDark29X29: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-32x32" asset catalog image.
    static var appIconIOSDark32X32: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-38x38" asset catalog image.
    static var appIconIOSDark38X38: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-40x40" asset catalog image.
    static var appIconIOSDark40X40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-512x512" asset catalog image.
    static var appIconIOSDark512X512: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-60x60" asset catalog image.
    static var appIconIOSDark60X60: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-64x64" asset catalog image.
    static var appIconIOSDark64X64: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-68x68" asset catalog image.
    static var appIconIOSDark68X68: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-76x76" asset catalog image.
    static var appIconIOSDark76X76: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-83.5x83.5" asset catalog image.
    static var appIconIOSDark835X835: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDark835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-1024x1024" asset catalog image.
    static var appIconIOSDefault1024X1024: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-128x128" asset catalog image.
    static var appIconIOSDefault128X128: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-16x16" asset catalog image.
    static var appIconIOSDefault16X16: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-20x20" asset catalog image.
    static var appIconIOSDefault20X20: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-256x256" asset catalog image.
    static var appIconIOSDefault256X256: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-29x29" asset catalog image.
    static var appIconIOSDefault29X29: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-32x32" asset catalog image.
    static var appIconIOSDefault32X32: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-38x38" asset catalog image.
    static var appIconIOSDefault38X38: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-40x40" asset catalog image.
    static var appIconIOSDefault40X40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-512x512" asset catalog image.
    static var appIconIOSDefault512X512: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-60x60" asset catalog image.
    static var appIconIOSDefault60X60: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-64x64" asset catalog image.
    static var appIconIOSDefault64X64: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-68x68" asset catalog image.
    static var appIconIOSDefault68X68: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-76x76" asset catalog image.
    static var appIconIOSDefault76X76: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-83.5x83.5" asset catalog image.
    static var appIconIOSDefault835X835: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSDefault835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-1024x1024" asset catalog image.
    static var appIconIOSTintedDark1024X1024: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-128x128" asset catalog image.
    static var appIconIOSTintedDark128X128: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-16x16" asset catalog image.
    static var appIconIOSTintedDark16X16: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-20x20" asset catalog image.
    static var appIconIOSTintedDark20X20: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-256x256" asset catalog image.
    static var appIconIOSTintedDark256X256: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-29x29" asset catalog image.
    static var appIconIOSTintedDark29X29: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-32x32" asset catalog image.
    static var appIconIOSTintedDark32X32: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-38x38" asset catalog image.
    static var appIconIOSTintedDark38X38: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-40x40" asset catalog image.
    static var appIconIOSTintedDark40X40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-512x512" asset catalog image.
    static var appIconIOSTintedDark512X512: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-60x60" asset catalog image.
    static var appIconIOSTintedDark60X60: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-64x64" asset catalog image.
    static var appIconIOSTintedDark64X64: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-68x68" asset catalog image.
    static var appIconIOSTintedDark68X68: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-76x76" asset catalog image.
    static var appIconIOSTintedDark76X76: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-83.5x83.5" asset catalog image.
    static var appIconIOSTintedDark835X835: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedDark835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-1024x1024" asset catalog image.
    static var appIconIOSTintedLight1024X1024: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-128x128" asset catalog image.
    static var appIconIOSTintedLight128X128: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-16x16" asset catalog image.
    static var appIconIOSTintedLight16X16: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-20x20" asset catalog image.
    static var appIconIOSTintedLight20X20: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-256x256" asset catalog image.
    static var appIconIOSTintedLight256X256: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-29x29" asset catalog image.
    static var appIconIOSTintedLight29X29: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-32x32" asset catalog image.
    static var appIconIOSTintedLight32X32: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-38x38" asset catalog image.
    static var appIconIOSTintedLight38X38: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-40x40" asset catalog image.
    static var appIconIOSTintedLight40X40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-512x512" asset catalog image.
    static var appIconIOSTintedLight512X512: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-60x60" asset catalog image.
    static var appIconIOSTintedLight60X60: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-64x64" asset catalog image.
    static var appIconIOSTintedLight64X64: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-68x68" asset catalog image.
    static var appIconIOSTintedLight68X68: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-76x76" asset catalog image.
    static var appIconIOSTintedLight76X76: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-83.5x83.5" asset catalog image.
    static var appIconIOSTintedLight835X835: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconIOSTintedLight835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-1088x1088" asset catalog image.
    static var appIconWatchOSDefault1088X1088: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault1088X1088)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-108x108" asset catalog image.
    static var appIconWatchOSDefault108X108: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault108X108)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-117x117" asset catalog image.
    static var appIconWatchOSDefault117X117: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault117X117)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-129x129" asset catalog image.
    static var appIconWatchOSDefault129X129: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault129X129)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-22x22" asset catalog image.
    static var appIconWatchOSDefault22X22: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault22X22)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-24x24" asset catalog image.
    static var appIconWatchOSDefault24X24: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault24X24)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-27.5x27.5" asset catalog image.
    static var appIconWatchOSDefault275X275: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault275X275)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-29x29" asset catalog image.
    static var appIconWatchOSDefault29X29: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-30x30" asset catalog image.
    static var appIconWatchOSDefault30X30: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault30X30)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-32x32" asset catalog image.
    static var appIconWatchOSDefault32X32: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-33x33" asset catalog image.
    static var appIconWatchOSDefault33X33: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault33X33)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-40x40" asset catalog image.
    static var appIconWatchOSDefault40X40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-43.5x43.5" asset catalog image.
    static var appIconWatchOSDefault435X435: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault435X435)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-44x44" asset catalog image.
    static var appIconWatchOSDefault44X44: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault44X44)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-46x46" asset catalog image.
    static var appIconWatchOSDefault46X46: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault46X46)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-50x50" asset catalog image.
    static var appIconWatchOSDefault50X50: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault50X50)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-51x51" asset catalog image.
    static var appIconWatchOSDefault51X51: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault51X51)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-54x54" asset catalog image.
    static var appIconWatchOSDefault54X54: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault54X54)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-86x86" asset catalog image.
    static var appIconWatchOSDefault86X86: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault86X86)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-98x98" asset catalog image.
    static var appIconWatchOSDefault98X98: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .appIconWatchOSDefault98X98)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "AppIcon-iOS-ClearDark-1024x1024" asset catalog image.
    static var appIconIOSClearDark1024X1024: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-128x128" asset catalog image.
    static var appIconIOSClearDark128X128: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-16x16" asset catalog image.
    static var appIconIOSClearDark16X16: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-20x20" asset catalog image.
    static var appIconIOSClearDark20X20: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-256x256" asset catalog image.
    static var appIconIOSClearDark256X256: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-29x29" asset catalog image.
    static var appIconIOSClearDark29X29: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-32x32" asset catalog image.
    static var appIconIOSClearDark32X32: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-38x38" asset catalog image.
    static var appIconIOSClearDark38X38: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-40x40" asset catalog image.
    static var appIconIOSClearDark40X40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-512x512" asset catalog image.
    static var appIconIOSClearDark512X512: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-60x60" asset catalog image.
    static var appIconIOSClearDark60X60: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-64x64" asset catalog image.
    static var appIconIOSClearDark64X64: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-68x68" asset catalog image.
    static var appIconIOSClearDark68X68: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-76x76" asset catalog image.
    static var appIconIOSClearDark76X76: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearDark-83.5x83.5" asset catalog image.
    static var appIconIOSClearDark835X835: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearDark835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-1024x1024" asset catalog image.
    static var appIconIOSClearLight1024X1024: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-128x128" asset catalog image.
    static var appIconIOSClearLight128X128: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-16x16" asset catalog image.
    static var appIconIOSClearLight16X16: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-20x20" asset catalog image.
    static var appIconIOSClearLight20X20: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-256x256" asset catalog image.
    static var appIconIOSClearLight256X256: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-29x29" asset catalog image.
    static var appIconIOSClearLight29X29: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-32x32" asset catalog image.
    static var appIconIOSClearLight32X32: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-38x38" asset catalog image.
    static var appIconIOSClearLight38X38: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-40x40" asset catalog image.
    static var appIconIOSClearLight40X40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-512x512" asset catalog image.
    static var appIconIOSClearLight512X512: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-60x60" asset catalog image.
    static var appIconIOSClearLight60X60: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-64x64" asset catalog image.
    static var appIconIOSClearLight64X64: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-68x68" asset catalog image.
    static var appIconIOSClearLight68X68: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-76x76" asset catalog image.
    static var appIconIOSClearLight76X76: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-ClearLight-83.5x83.5" asset catalog image.
    static var appIconIOSClearLight835X835: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSClearLight835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-1024x1024" asset catalog image.
    static var appIconIOSDark1024X1024: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-128x128" asset catalog image.
    static var appIconIOSDark128X128: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-16x16" asset catalog image.
    static var appIconIOSDark16X16: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-20x20" asset catalog image.
    static var appIconIOSDark20X20: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-256x256" asset catalog image.
    static var appIconIOSDark256X256: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-29x29" asset catalog image.
    static var appIconIOSDark29X29: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-32x32" asset catalog image.
    static var appIconIOSDark32X32: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-38x38" asset catalog image.
    static var appIconIOSDark38X38: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-40x40" asset catalog image.
    static var appIconIOSDark40X40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-512x512" asset catalog image.
    static var appIconIOSDark512X512: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-60x60" asset catalog image.
    static var appIconIOSDark60X60: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-64x64" asset catalog image.
    static var appIconIOSDark64X64: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-68x68" asset catalog image.
    static var appIconIOSDark68X68: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-76x76" asset catalog image.
    static var appIconIOSDark76X76: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Dark-83.5x83.5" asset catalog image.
    static var appIconIOSDark835X835: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDark835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-1024x1024" asset catalog image.
    static var appIconIOSDefault1024X1024: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-128x128" asset catalog image.
    static var appIconIOSDefault128X128: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-16x16" asset catalog image.
    static var appIconIOSDefault16X16: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-20x20" asset catalog image.
    static var appIconIOSDefault20X20: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-256x256" asset catalog image.
    static var appIconIOSDefault256X256: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-29x29" asset catalog image.
    static var appIconIOSDefault29X29: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-32x32" asset catalog image.
    static var appIconIOSDefault32X32: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-38x38" asset catalog image.
    static var appIconIOSDefault38X38: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-40x40" asset catalog image.
    static var appIconIOSDefault40X40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-512x512" asset catalog image.
    static var appIconIOSDefault512X512: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-60x60" asset catalog image.
    static var appIconIOSDefault60X60: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-64x64" asset catalog image.
    static var appIconIOSDefault64X64: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-68x68" asset catalog image.
    static var appIconIOSDefault68X68: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-76x76" asset catalog image.
    static var appIconIOSDefault76X76: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-Default-83.5x83.5" asset catalog image.
    static var appIconIOSDefault835X835: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSDefault835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-1024x1024" asset catalog image.
    static var appIconIOSTintedDark1024X1024: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-128x128" asset catalog image.
    static var appIconIOSTintedDark128X128: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-16x16" asset catalog image.
    static var appIconIOSTintedDark16X16: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-20x20" asset catalog image.
    static var appIconIOSTintedDark20X20: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-256x256" asset catalog image.
    static var appIconIOSTintedDark256X256: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-29x29" asset catalog image.
    static var appIconIOSTintedDark29X29: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-32x32" asset catalog image.
    static var appIconIOSTintedDark32X32: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-38x38" asset catalog image.
    static var appIconIOSTintedDark38X38: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-40x40" asset catalog image.
    static var appIconIOSTintedDark40X40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-512x512" asset catalog image.
    static var appIconIOSTintedDark512X512: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-60x60" asset catalog image.
    static var appIconIOSTintedDark60X60: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-64x64" asset catalog image.
    static var appIconIOSTintedDark64X64: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-68x68" asset catalog image.
    static var appIconIOSTintedDark68X68: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-76x76" asset catalog image.
    static var appIconIOSTintedDark76X76: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedDark-83.5x83.5" asset catalog image.
    static var appIconIOSTintedDark835X835: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedDark835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-1024x1024" asset catalog image.
    static var appIconIOSTintedLight1024X1024: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight1024X1024)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-128x128" asset catalog image.
    static var appIconIOSTintedLight128X128: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight128X128)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-16x16" asset catalog image.
    static var appIconIOSTintedLight16X16: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight16X16)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-20x20" asset catalog image.
    static var appIconIOSTintedLight20X20: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight20X20)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-256x256" asset catalog image.
    static var appIconIOSTintedLight256X256: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight256X256)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-29x29" asset catalog image.
    static var appIconIOSTintedLight29X29: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-32x32" asset catalog image.
    static var appIconIOSTintedLight32X32: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-38x38" asset catalog image.
    static var appIconIOSTintedLight38X38: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight38X38)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-40x40" asset catalog image.
    static var appIconIOSTintedLight40X40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-512x512" asset catalog image.
    static var appIconIOSTintedLight512X512: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight512X512)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-60x60" asset catalog image.
    static var appIconIOSTintedLight60X60: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight60X60)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-64x64" asset catalog image.
    static var appIconIOSTintedLight64X64: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight64X64)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-68x68" asset catalog image.
    static var appIconIOSTintedLight68X68: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight68X68)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-76x76" asset catalog image.
    static var appIconIOSTintedLight76X76: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight76X76)
#else
        .init()
#endif
    }

    /// The "AppIcon-iOS-TintedLight-83.5x83.5" asset catalog image.
    static var appIconIOSTintedLight835X835: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconIOSTintedLight835X835)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-1088x1088" asset catalog image.
    static var appIconWatchOSDefault1088X1088: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault1088X1088)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-108x108" asset catalog image.
    static var appIconWatchOSDefault108X108: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault108X108)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-117x117" asset catalog image.
    static var appIconWatchOSDefault117X117: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault117X117)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-129x129" asset catalog image.
    static var appIconWatchOSDefault129X129: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault129X129)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-22x22" asset catalog image.
    static var appIconWatchOSDefault22X22: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault22X22)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-24x24" asset catalog image.
    static var appIconWatchOSDefault24X24: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault24X24)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-27.5x27.5" asset catalog image.
    static var appIconWatchOSDefault275X275: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault275X275)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-29x29" asset catalog image.
    static var appIconWatchOSDefault29X29: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault29X29)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-30x30" asset catalog image.
    static var appIconWatchOSDefault30X30: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault30X30)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-32x32" asset catalog image.
    static var appIconWatchOSDefault32X32: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault32X32)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-33x33" asset catalog image.
    static var appIconWatchOSDefault33X33: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault33X33)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-40x40" asset catalog image.
    static var appIconWatchOSDefault40X40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault40X40)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-43.5x43.5" asset catalog image.
    static var appIconWatchOSDefault435X435: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault435X435)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-44x44" asset catalog image.
    static var appIconWatchOSDefault44X44: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault44X44)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-46x46" asset catalog image.
    static var appIconWatchOSDefault46X46: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault46X46)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-50x50" asset catalog image.
    static var appIconWatchOSDefault50X50: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault50X50)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-51x51" asset catalog image.
    static var appIconWatchOSDefault51X51: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault51X51)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-54x54" asset catalog image.
    static var appIconWatchOSDefault54X54: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault54X54)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-86x86" asset catalog image.
    static var appIconWatchOSDefault86X86: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault86X86)
#else
        .init()
#endif
    }

    /// The "AppIcon-watchOS-Default-98x98" asset catalog image.
    static var appIconWatchOSDefault98X98: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .appIconWatchOSDefault98X98)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

