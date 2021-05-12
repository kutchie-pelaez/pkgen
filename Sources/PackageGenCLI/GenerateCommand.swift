import SwiftCLI
import PathKit
import Core
import Generation
import Foundation

final class GenerateCommand: Command {

    let name = "generate"
    let shortDescription = "Generates package files based on manifests"

    private let configurartionPath: Path = .current + Constants.defaultConfigurationFileFullname

    func execute() throws {
        try checkPathAndGoDeeperIfNeeded(.current, configurartionPath: configurartionPath)
    }
}

private extension GenerateCommand {

    func checkPathAndGoDeeperIfNeeded(_ path: Path, configurartionPath: Path) throws {
        guard path.isDirectory else { return }

        let children = try path.children()

        for child in children {
            if child.isDirectory {
                try checkPathAndGoDeeperIfNeeded(child, configurartionPath: configurartionPath)
            } else if child.isFile {
                try generatePackageFileIfNeeded(at: child, configurartionPath: configurartionPath)
            }
        }
    }

    func generatePackageFileIfNeeded(at path: Path, configurartionPath: Path) throws {
        guard path.isFile && path.lastComponent == Constants.defaultManifestFileFullname else { return }

        let packagePath = path.parent() + "Package.swift"
        let writer = PackageFileWriter(configurationPath: configurartionPath)
        try writer.write(from: path, to: packagePath)
    }
}
