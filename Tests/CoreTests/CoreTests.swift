@testable import Core
import XCTest
import PathKit

// MARK: - Parsed files

private var emptyPackagefile: Packagefile?
private var fullPackagefile: Packagefile?
private var emptyManifestWithEmptyPackagefile: Manifest?
private var emptyManifestWithFullPackagefile: Manifest?
private var fullManifestWithEmptyPackagefile: Manifest?
private var fullManifestWithFullPackagefile: Manifest?

// MARK: - Fixture files helpers

private let emptyPackagefilePath = Path(#file).parent().parent().parent() + "Fixtures" + "Packagefile_empty"
private let fullPackagefilePath = Path(#file).parent().parent().parent() + "Fixtures" + "Packagefile_full"
private let emptyManifestPath = Path(#file).parent().parent().parent() + "Fixtures" + "package_empty.yml"
private let fullManifestPath = Path(#file).parent().parent().parent() + "Fixtures" + "package_full.yml"

// MARK: - Tests

final class CoreTests: XCTestCase {

    func test01_emptyPackagefileParsing() { testPackagefileParsing(at: emptyPackagefilePath, saveTo: &emptyPackagefile) }
    func test02_emptyPackagefileComparing() { testPackagefilesComparing(emptyPackagefile, Self.expectedEmptyPackagefile) }
    func test03_fullPackagefileParsing() { testPackagefileParsing(at: fullPackagefilePath, saveTo: &fullPackagefile) }
    func test04_fullPackagefileComparing() { testPackagefilesComparing(fullPackagefile, Self.expectedFullPackagefile) }
    func test05_emptyManifestWithEmptyPackagefileParsing() { testManifestParsing(at: emptyManifestPath, with: emptyPackagefile, saveTo: &emptyManifestWithEmptyPackagefile) }
    func test06_emptyManifestWithEmptyPackagefileComparing() { testManifestsComparing(emptyManifestWithEmptyPackagefile, Self.expectedEmptyManifestWithEmptyPackagefile) }
    func test07_emptyManifestWithFullPackagefileParsing() { testManifestParsing(at: emptyManifestPath, with: fullPackagefile, saveTo: &emptyManifestWithFullPackagefile) }
    func test08_emptyManifestWithFullPackagefileComparing() { testManifestsComparing(emptyManifestWithFullPackagefile, Self.expectedEmptyManifestWithFullPackagefile) }
    func test09_fullManifestWithEmptyPackagefileParsing() { testManifestParsing(at: fullManifestPath, with: emptyPackagefile, saveTo: &fullManifestWithEmptyPackagefile) }
    func test10_fullManifestWithEmptyPackagefileComparing() { testManifestsComparing(fullManifestWithEmptyPackagefile, Self.expectedFullManifestWithEmptyPackagefile) }
    func test11_fullManifestWithFullPackagefileParsing() { testManifestParsing(at: fullManifestPath, with: fullPackagefile, saveTo: &fullManifestWithFullPackagefile) }
    func test12_fullManifestWithFullPackagefileComparing() { testManifestsComparing(fullManifestWithFullPackagefile, Self.expectedFullManifestWithFullPackagefile) }
}
