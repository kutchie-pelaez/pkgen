import SwiftCLI
import PathKit
import Core
import Foundation

final class GenerateCommand: Command {

    let name = "generate"
    let shortDescription = "Generates package files based on manifests"

    func execute() throws {
        let configFilePath: Path = .current + Constants.defaultConfigurationFileFullname
        let configData = try configFilePath.read()
        let configurartion = try Configuration(from: configData)

        checkPathAndGoDeeperIfNeeded(at: .current,
                                     with: configurartion)
    }
}

private extension GenerateCommand {

    func checkPathAndGoDeeperIfNeeded(at path: Path, with configurartion: Configuration) {
        guard path.isDirectory else { return }

        for component in (try? path.children()) ?? [] {
            if component.isDirectory {
                checkPathAndGoDeeperIfNeeded(at: component,
                                             with: configurartion)
            } else if component.isFile {
                createPackageFileIfNeeded(at: component,
                                          with: configurartion)
            }
        }
    }

    func createPackageFileIfNeeded(at path: Path, with configurartion: Configuration) {
        guard path.isFile &&
              path.lastComponent == Constants.defaultManifestFileFullname,
              let manifestData = try? path.read() else {
            return
        }

        guard let _ = try? Manifest(
            from: manifestData,
            at: path,
            with: configurartion
        ) else {
            return
        }

        // TODO: - Generate Package.swift file here
    }
}
