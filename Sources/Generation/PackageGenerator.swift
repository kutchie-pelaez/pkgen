import Foundation
import Core

final class PackageGenerator {

    private let manifest: Manifest

    init(with manifest: Manifest) {
        self.manifest = manifest
    }

    public func generateRawPackageBasedOnManifest() throws -> String {
        fatalError()
    }

    // MARK: - Generation errors

//    public enum PackageGeneratorError: Error {
//
//    }
}
