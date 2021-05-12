import Foundation
import Core

final class PackageGenerator {

    private let manifest: Manifest

    init(with manifest: Manifest) {
        self.manifest = manifest
    }

    public func generateRawPackageBasedOnManifest() throws -> String {
        let header = SwiftToolsVersion(manifest.swiftToolsVersion)
            .newLines(2)
            .import("PackageDescription")
            .newLines(2)

        let packageDeclartion = PackageDeclarationStart()
            .newLine

        let name = Name(manifest.name, isLastArgument: false)
            .indented(with: .tab)
            .newLine

        let platforms = Platforms(manifest.platforms, isLastArgument: false)
            .indented(with: .tab)
            .newLine

        let products = Products(manifest.products, isLastArgument: false)
            .indented(with: .tab)
            .newLine

        let dependencies = Dependencies(manifest.dependencies, isLastArgument: false)
            .indented(with: .tab)
            .newLine

        let targets = Targets(manifest.targets, isLastArgument: true)
            .indented(with: .tab)
            .newLine

        return header
            .chain(packageDeclartion)
            .chain(name)
            .chain(platforms)
            .chain(products)
            .chain(dependencies)
            .chain(targets)
            .parenthesis(type: .closed)
            .newLine
            .string
    }
}
