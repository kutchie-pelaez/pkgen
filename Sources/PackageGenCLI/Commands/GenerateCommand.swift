import SwiftCLI
import PathKit
import ManifestGenerator
import Foundation
import Rainbow

final class GenerateCommand {

    private let start = CFAbsoluteTimeGetCurrent()
    private let cache = Cache()
    private var successfullyGeneratedPackagePaths = [Path]()

    @Flag("-q", "--quietly", description: "Completly disable logs")
    var quietly: Bool

    @Flag("--use-cache", description: "Generate packages only if package.yml or Packagefile was changed")
    var useCache: Bool

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

        if useCache &&
           !successfullyGeneratedPackagePaths.isEmpty {
            do {
                try cache.createCacheFile(from: successfullyGeneratedPackagePaths)
                stdout("\n✅ Cache successfully updated at \(cache.path)".green)
            } catch let error {
                stdout("\nFailed to write cache, error: \(error.localizedDescription)".red)
            }
        }

        if successfullyGeneratedPackagePaths.isEmpty {
            stdout("Nothing changed since last generation\n")
        } else {
            stdout("\nFinished in \(milisecondsPassed) ms\n")
        }
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

    func stdout(_ content: String, terminator: String = "\n") {
        guard !quietly else { return }

        stdout.print(content, terminator: terminator)
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
        guard (!useCache || !cache.isFileSameSinceLastGeneration(at: manifestPath)) &&
              manifestPath.isFile && manifestPath.lastComponent == "package.yml" else {
            return
        }

        let packageOutputPath = manifestPath.parent() + "Package.swift"
        let currentPathString = Path.current.string
        let relativePackageOutputPath = Path(packageOutputPath.string.replacingOccurrences(of: currentPathString, with: ""))

        stdout("Generating package at \(relativePackageOutputPath)...".lightYellow)

        let writer = PackageFileWriter(packagefilePath: packagefilePath)
        do {
            try writer.write(manifestPath: manifestPath, packageOutputPath: packageOutputPath)
            successfullyGeneratedPackagePaths.append(manifestPath)
        } catch let error {
            stdout("\nFailed to generate package file at \(relativePackageOutputPath)...".red)
            throw error
        }
    }
}
