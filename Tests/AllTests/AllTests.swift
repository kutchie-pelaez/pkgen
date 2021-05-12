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

// MARK: - Tests

final class AllTests: XCTestCase {

    func testConfigurationParsing() {
        do {
            let configData = try projectConfigPath.read()
            projectConfig = try Configuration(from: configData)
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }

    func testModuleAPackageFileGeneration() { testPackageFileGeneration(for: .A) }
    func testModuleBPackageFileGeneration() { testPackageFileGeneration(for: .B) }
    func testModuleCPackageFileGeneration() { testPackageFileGeneration(for: .C) }
    func testModuleDPackageFileGeneration() { testPackageFileGeneration(for: .D) }
}

// MARK: - Private

private extension AllTests {

    func testPackageFileGeneration(for module: FixtureProjectModule) {
        cleanGeneratedFiles(for: module)

        do {
            let writer = PackageFileWriter(configurationPath: projectConfigPath)
            try writer.write(from: module.manifestPath, to: module.packagePath)

            let generatedPackageData = try module.packagePath.read()
            let expectationPackageData = try module.expectationPackagePath.read()

            guard let generatedPackageRawString = String(data: generatedPackageData, encoding: .utf8) else { return XCTAssert(false, "Failed to read generated package file") }
            guard let expectationPackageRawString = String(data: expectationPackageData, encoding: .utf8) else { return XCTAssert(false, "Failed to read expectation package file") }

            XCTAssertEqual(generatedPackageRawString, expectationPackageRawString, "Generated package file is not equal to what was expected")
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }

        cleanGeneratedFiles(for: module)
    }

    func cleanGeneratedFiles(for module: FixtureProjectModule) {
        try? module.packagePath.delete()
    }
}
