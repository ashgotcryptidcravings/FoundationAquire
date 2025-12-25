import Foundation
import SwiftUI
import QuickLook

/// A lightweight SwiftUI wrapper around `QLPreviewController`.
/// Use it with `.sheet`/`.fullScreenCover` to present a USDZ with system Quick Look (supports AR).
struct QuickLookPreview: UIViewControllerRepresentable {
    let url: URL

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIViewController(context: Context) -> QLPreviewController {
        let ctrl = QLPreviewController()
        ctrl.dataSource = context.coordinator
        ctrl.delegate = context.coordinator
        return ctrl
    }

    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {
        // nothing to update; data source already provides item
    }

    final class Coordinator: NSObject, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
        let parent: QuickLookPreview
        init(_ parent: QuickLookPreview) { self.parent = parent }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            parent.url as NSURL
        }

        func previewControllerDidDismiss(_ controller: QLPreviewController) {
            // no-op; host sheet will dismiss
        }
    }
}
