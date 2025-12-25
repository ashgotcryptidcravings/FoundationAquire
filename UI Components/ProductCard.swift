import SwiftUI
import QuickLook
import UIKit
// Platform imports: prefer UIKit on iOS/tvOS, AppKit on macOS. Provide a PlatformImage alias
// so UI code can remain platform-agnostic.
#if canImport(UIKit)
import UIKit
typealias PlatformImage = UIImage
#elseif canImport(AppKit)
import AppKit
typealias PlatformImage = NSImage
#else
enum PlatformImage {}
#endif

/// Local Quick Look wrapper (inline) to avoid cross-file ordering issues during incremental builds.
#if canImport(UIKit)
private struct InlineQuickLook: UIViewControllerRepresentable {
    let url: URL

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> QLPreviewController {
        let ctrl = QLPreviewController()
        ctrl.dataSource = context.coordinator
        ctrl.delegate = context.coordinator
        return ctrl
    }

    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {}

    final class Coordinator: NSObject, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
        let parent: InlineQuickLook
        init(_ parent: InlineQuickLook) { self.parent = parent }
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem { parent.url as NSURL }
    }
}
#endif

struct ProductCard: View {
    let product: Product

    @EnvironmentObject private var store: StoreModel
    @State private var showingModel = false
    @State private var showingQuickLook = false
    @State private var quickLookURL: URL? = nil
    @State private var showPreviewOptions = false

    // Thumbnail caching (platform-agnostic)
    @State private var thumbnailImage: PlatformImage? = nil

    private var key: String? {
        ProductCatalog.key(for: product)
    }

    private var isWishlisted: Bool {
        key.map { store.isWishlisted($0) } ?? false
    }

    var body: some View {
        AquireSurface {
            VStack(alignment: .leading, spacing: 12) {

                // Thumbnail: prefer cached bundled thumbnail, otherwise fallback to system image.
                Group {
                    if let ui = thumbnailImage {
                        #if canImport(UIKit)
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFit()
                        #elseif canImport(AppKit)
                        Image(nsImage: ui)
                            .resizable()
                            .scaledToFit()
                        #else
                        Image(systemName: product.imageSystemName)
                            .resizable()
                            .scaledToFit()
                        #endif
                    } else {
                        Image(systemName: product.imageSystemName)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white.opacity(0.9))
                .padding(.bottom, 4)
                .task {
                    guard let thumb = product.thumbnailName else { return }

                    #if canImport(UIKit)
                    await Task.detached {
                        let ui = UIImage(named: thumb)
                        await MainActor.run {
                            thumbnailImage = ui
                        }
                    }.value
                    #elseif canImport(AppKit)
                    await Task.detached {
                        let name = NSImage.Name(thumb)
                        let ns = NSImage(named: name)
                        await MainActor.run {
                            thumbnailImage = ns
                        }
                    }.value
                    #else
                    // no-op
                    #endif
                }

                Text(product.name)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text(product.description)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))

                HStack {
                    Text(product.price, format: .currency(code: "USD"))
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Spacer()

                    Button {
                        guard let key else { return }
                        store.toggleWishlist(key)
                    } label: {
                        Image(systemName: isWishlisted ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                }

                if product.modelName != nil {
                    Button {
                        // If a bundled usdz exists, offer both embedded preview and Quick Look AR.
                        if let modelName = product.modelName,
                           let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
                            quickLookURL = url
                            showPreviewOptions = true
                        } else {
                            // No usdz available in bundle — fall back to embedded SceneKit preview.
                            showingModel = true
                        }
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "cube.transparent")
                            Text("View in 3D")
                        }
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.10))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }
                    .buttonStyle(.plain)
                    .confirmationDialog("Preview Options", isPresented: $showPreviewOptions, titleVisibility: .visible) {
                        Button("Embedded Preview") { showingModel = true }
                        if quickLookURL != nil {
                            Button("Open in Quick Look (AR)") { showingQuickLook = true }
                        }
                        Button("Cancel", role: .cancel) { }
                    }
                    .sheet(isPresented: $showingModel) {
                        if let modelName = product.modelName {
                            ModelViewerSheet(modelName: modelName)
                        }
                    }
                    .sheet(isPresented: $showingQuickLook) {
                        if let url = quickLookURL {
                            #if canImport(UIKit)
                            InlineQuickLook(url: url)
                                .ignoresSafeArea()
                            #else
                            VStack {
                                Text("Preview not available on this platform")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .background(Color.black)
                            #endif
                        }
                    }
                }
            }
        }
    }
}
