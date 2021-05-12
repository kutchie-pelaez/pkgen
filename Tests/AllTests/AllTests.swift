@testable import Generation
import XCTest
import PathKit
import Core

private let projectPath = Path(#file).parent() + "FixtureProject"
private let projectConfigPath = projectPath + "pkgconfig.yml"
private var projectConfig: Configuration!

enum FixtureProjectModule: String, CaseIterable {
    case A, B, C, D

    var name: String { "Module\(rawValue)" }
    var path: Path { projectPath + "packages" + name }
    var manifestPath: Path { path + "manifest.yml" }
    var packagePath: Path { path + "Package.swift" }
    var expectationPackagePath: Path { path + "Expectation.Package.swift" }
}

final class AllTests: XCTestCase {

    func testConfigurationParsing() {
        do {
            let configData = try projectConfigPath.read()
            projectConfig = try Configuration(from: configData)
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }

    func testAllModuleGeneration() {
        FixtureProjectModule.allCases.forEach(testPackageFileGeneration)
    }

    func testPackageFileGeneration(for module: FixtureProjectModule) {
        
    }
}
