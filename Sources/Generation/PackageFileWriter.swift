import PathKit
import Core
import Foundation

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

        let generator = PackageGenerator(with: manifest)
        let rawResult = try generator.generateRawPackageBasedOnManifest()

        try writeRawStringToPackageFile(rawResult, at: packageOutputPath)
    }

    private func writeRawStringToPackageFile(_ string: String, at path: Path) throws {
        guard let data = string.data(using: .utf8) else { throw PackageFileWriterError.invalidPackageData }
        
        try path.write(data)
    }

    // MARK: - Writing errors

    public enum PackageFileWriterError: Error {
        case noConfigurationFileSpecified
        case noManifestFileSpecified
        case invalidPackageData
    }
}
