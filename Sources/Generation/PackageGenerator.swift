import Foundation
import Core

final class PackageGenerator {

    private let manifest: Manifest

    init(with manifest: Manifest) {
        self.manifest = manifest
    }

    public func generateRawPackageBasedOnManifest() throws -> String {
        Empty()
            // Header & import
            .swiftToolsVersion(manifest.swiftToolsVersion).newLines(2)
            .import("PackageDescription").newLines(2)

            // Core components
            .packageDeclarationStart.newLine
            .name(manifest.name, isLastArgument: false).newLine
            .platforms(manifest.platforms, isLastArgument: false).newLine
            .products(manifest.products, isLastArgument: false).newLine

            // Ending
            .parenthesis(type: .closed)
            .newLine

            .string
    }
}
