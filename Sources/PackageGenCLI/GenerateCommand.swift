import SwiftCLI
import PathKit
import Generation

final class GenerateCommand: Command {

    let name = "generate"
    let shortDescription = "Generates package files based on manifests"

    private let packagefilePath: Path = .current + "Packagefile"

    func execute() throws {
        try checkPathAndGoDeeperIfNeeded(.current, packagefilePath: packagefilePath)
    }
}

private extension GenerateCommand {

    func checkPathAndGoDeeperIfNeeded(_ path: Path, packagefilePath: Path) throws {
        guard path.isDirectory else { return }

        let children = try path.children()

        for child in children {
            if child.isDirectory {
                try checkPathAndGoDeeperIfNeeded(child, packagefilePath: packagefilePath)
            } else if child.isFile {
                try generatePackageFileIfNeeded(at: child, packagefilePath: packagefilePath)
            }
        }
    }

    func generatePackageFileIfNeeded(at path: Path, packagefilePath: Path) throws {
        guard path.isFile && path.lastComponent == "package.yml" else { return }

        let packagePath = path.parent() + "Package.swift"
        let writer = PackageFileWriter(packagefilePath: packagefilePath)
        try writer.write(from: path, to: packagePath)
    }
}
