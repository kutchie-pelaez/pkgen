import SwiftCLI
import PathKit
import CodeGeneration
import Foundation
import Rainbow

final class GenerateCommand {

    private let start = CFAbsoluteTimeGetCurrent()

    @Flag("-q", "--quietly", description: "Completly disable logs")
    var quietly: Bool

    // MARK: - Routable

    let name = "generate"

    let shortDescription = "Generates package files based on manifests"
}

// MARK: - Command

extension GenerateCommand: Command {

    func execute() throws {
        try checkPathAndGoDeeperIfNeeded(
            .current,
            packagefilePath: packagefilePath
        )

        stdout("\n✅ Finished in \(milisecondsPassed) ms".cyan)
    }
}

// MARK: - Private

private extension GenerateCommand {

    var milisecondsPassed: Int {
        let diff = CFAbsoluteTimeGetCurrent() - start

        return Int(diff * 1000)
    }

    var packagefilePath: Path {
        .current + "Packagefile"
    }

    func stdout(_ content: String) {
        guard !quietly else { return }

        stdout.print(content)
    }

    func checkPathAndGoDeeperIfNeeded(_ path: Path, packagefilePath: Path) throws {
        guard path.isDirectory else { return }

        let children = try path.children()

        for child in children {
            if child.isDirectory {
                try checkPathAndGoDeeperIfNeeded(child, packagefilePath: packagefilePath)
            } else if child.isFile {
                try generatePackageFileIfNeeded(manifestPath: child, packagefilePath: packagefilePath)
            }
        }
    }

    func generatePackageFileIfNeeded(manifestPath: Path, packagefilePath: Path) throws {
        guard manifestPath.isFile && manifestPath.lastComponent == "package.yml" else { return }

        let packageOutputPath = manifestPath.parent() + "Package.swift"
        let currentPathString = Path.current.string
        let relativePackageOutputPath = Path(packageOutputPath.string.replacingOccurrences(of: currentPathString, with: ""))

        stdout("Generating package at \(relativePackageOutputPath)...".lightYellow)

        let writer = PackageFileWriter(packagefilePath: packagefilePath)
        do {
            try writer.write(manifestPath: manifestPath, packageOutputPath: packageOutputPath)
        } catch let error {
            stdout("Failed to generate package file at \(relativePackageOutputPath)...".red)
            throw error
        }
    }
}
