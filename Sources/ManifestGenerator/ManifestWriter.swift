import PathKit
import Core

public final class ManifestWriter {

    private let packagefilePath: Path

    private func packagefile() throws -> Packagefile {
        guard let packagefileData = try? packagefilePath.read() else { throw ManifestWriterError.noPackagefileSpecified }

        return try Packagefile(from: packagefileData)
    }

    public init(packagefilePath: Path) {
        self.packagefilePath = packagefilePath
    }

    public func write(manifestPath: Path, packageOutputPath: Path) throws {
        guard let manifestData = try? manifestPath.read() else { throw ManifestWriterError.noManifestFileSpecified }

        let packagefile = try packagefile()
        let manifest = try Manifest(
            from: manifestData,
            at: manifestPath,
            with: packagefile
        )

        let generator = ManifestGenerator(with: manifest)
        let rawResult = generator.generateRawPackageString()

        try writeRawStringToPackageFile(rawResult, at: packageOutputPath)
    }

    private func writeRawStringToPackageFile(_ string: String, at path: Path) throws {
        guard let data = string.data(using: .utf8) else { throw ManifestWriterError.invalidPackageData }
        
        try path.write(data)
    }

    // MARK: - Writing errors

    public enum ManifestWriterError: Error {
        case noPackagefileSpecified
        case noManifestFileSpecified
        case invalidPackageData
    }
}
