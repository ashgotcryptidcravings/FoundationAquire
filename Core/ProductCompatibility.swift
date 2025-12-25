import Foundation

// Backwards-compatibility convenience initializer for `Product`.
// Some product lists in the repo call the synthesized memberwise initializer without the new `thumbnailName` parameter.
// This extension provides an initializer that supplies `thumbnailName: nil` so we don't need to edit every site.
extension Product {
    init(
        name: String,
        price: Double,
        imageSystemName: String,
        category: String,
        description: String,
        modelName: String?
    ) {
        self.init(
            name: name,
            price: price,
            imageSystemName: imageSystemName,
            category: category,
            description: description,
            modelName: modelName,
            thumbnailName: nil
        )
    }
}
