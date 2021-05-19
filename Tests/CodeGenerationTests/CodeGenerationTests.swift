@testable import ManifestGenerator
import XCTest
import PathKit
import Core

// MARK: - Paths

private let projectPath = Path(#file).parent().parent().parent() + "Fixtures" + "project"
private let packagefilePath = projectPath + "Packagefile"

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

final class ManifestGeneratorTests: XCTestCase {

    func test1_moduleAPackageFileGeneration() { testPackageFileGeneration(for: .A) }
    func test2_moduleBPackageFileGeneration() { testPackageFileGeneration(for: .B) }
    func test3_moduleCPackageFileGeneration() { testPackageFileGeneration(for: .C) }
    func test4_moduleDPackageFileGeneration() { testPackageFileGeneration(for: .D) }
}

// MARK: - Private

private extension ManifestGeneratorTests {

    func testPackageFileGeneration(for package: Package) {
        do {
            let writer = PackageFileWriter(packagefilePath: packagefilePath)
            try writer.write(manifestPath: package.manifestPath, packageOutputPath: package.packagePath)

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
