import SwiftUI
import QuickLook

/// A reusable Quick Look wrapper for viewing USDZ / 3D models full-screen.
struct ModelQuickLookView: UIViewControllerRepresentable {
    let url: URL
    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, url: url)
    }

    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {
        // No dynamic updates needed while presented.
    }

    // MARK: - Coordinator

    final class Coordinator: NSObject, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
        @Binding var isPresented: Bool
        let item: QLPreviewItem

        init(isPresented: Binding<Bool>, url: URL) {
            self._isPresented = isPresented
            self.item = URLPreviewItem(url: url)
            super.init()
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }

        func previewController(_ controller: QLPreviewController,
                               previewItemAt index: Int) -> QLPreviewItem {
            item
        }

        func previewControllerDidDismiss(_ controller: QLPreviewController) {
            // Make sure SwiftUI knows it's gone
            isPresented = false
        }
    }
}

/// Simple QLPreviewItem implementation wrapping a URL.
final class URLPreviewItem: NSObject, QLPreviewItem {
    let previewItemURL: URL?

    init(url: URL) {
        self.previewItemURL = url
        super.init()
    }
}
