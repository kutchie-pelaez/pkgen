import PathKit
import Core

public final class PackageFileWriter {

    private let configurationPath: Path
    private func configuration() throws -> Configuration {
        guard let configurationData = try? configurationPath.read() else { throw PackageFileWriterError.noConfigurationFileSpecified }

        return try Configuration(from: configurationData)
    }

    public init(configurationPath: Path) {
        self.configurationPath = configurationPath
    }

    public func generate(manifestInputPath: Path, packageOutputPath: Path) throws {
        guard let manifestData = try? manifestInputPath.read() else { throw PackageFileWriterError.noManifestFileSpecified }

        let configuration = try configuration()
        let manifest = try Manifest(
            from: manifestData,
            at: manifestInputPath,
            with: configuration
        )
    }

    // MARK: - Writing errors

    public enum PackageFileWriterError: Error {
        case noConfigurationFileSpecified
        case noManifestFileSpecified
    }
}
