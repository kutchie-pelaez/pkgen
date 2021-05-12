@testable import Generation
import XCTest
import PathKit
import Core

// MARK: - Paths

private let projectPath = Path(#file).parent().parent().parent() + "DummyProject"
private let packagefilePath = projectPath + "Packagefile"
private var configuration: Configuration!

// MARK: - All packages from dummy project

enum Package: String, CaseIterable {
    case A, B, C, D

    var name: String { "Package\(rawValue)" }
    var path: Path { projectPath + "packages" + name }
    var manifestPath: Path { path + "package.yml" }
    var packagePath: Path { path + "Package.swift" }
    var expectationPackagePath: Path { path + "Expectation.Package.swift" }
}

// MARK: - Tests

final class GenerationTests: XCTestCase {

    func testConfigurationParsing() {
        do {
            let configData = try packagefilePath.read()
            configuration = try Configuration(from: configData)
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

private extension GenerationTests {

    func testPackageFileGeneration(for package: Package) {
        do {
            let writer = PackageFileWriter(configurationPath: packagefilePath)
            try writer.write(from: package.manifestPath, to: package.packagePath)

            let generatedPackageData = try package.packagePath.read()
            let expectationPackageData = try package.expectationPackagePath.read()

            guard let generatedPackageRawString = String(data: generatedPackageData, encoding: .utf8) else { return XCTAssert(false, "Failed to read generated package file") }
            guard let expectationPackageRawString = String(data: expectationPackageData, encoding: .utf8) else { return XCTAssert(false, "Failed to read expectation package file") }

            XCTAssertEqual(generatedPackageRawString, expectationPackageRawString, "Generated package file is not equal to what was expected")
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
