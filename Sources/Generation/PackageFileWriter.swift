import PathKit
import Core

public final class PackageFileWriter {

    private let packagefilePath: Path
    private func packagefile() throws -> Packagefile {
        guard let packagefileData = try? packagefilePath.read() else { throw PackageFileWriterError.noPackagefileSpecified }

        return try Packagefile(from: packagefileData)
    }

    public init(packagefilePath: Path) {
        self.packagefilePath = packagefilePath
    }

    public func write(from manifestInputPath: Path, to packageOutputPath: Path) throws {
        guard let manifestData = try? manifestInputPath.read() else { throw PackageFileWriterError.noManifestFileSpecified }

        let packagefile = try packagefile()
        let manifest = try Manifest(
            from: manifestData,
            at: manifestInputPath,
            with: packagefile
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
        case noPackagefileSpecified
        case noManifestFileSpecified
        case invalidPackageData
    }
}
