import Foundation
import Core

final class PackageGenerator {

    private let manifest: Manifest

    init(with manifest: Manifest) {
        self.manifest = manifest
    }

    public func generateRawPackageBasedOnManifest() throws -> String {
        Empty()
            .swiftToolsVersion(manifest.swiftToolsVersion)
            .newLine
            .newLine
            .import("PackageDescription")
            .newLine
            .newLine

            .string
    }
}
