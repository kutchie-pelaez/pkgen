@testable import Core
import XCTest
import PathKit

private var dummyPackagefilePath = Path(#file).parent() + "DummyPackagefile"
private var dummyManifestPath = Path(#file).parent() + "dummy_package.yml"
private var packagefile: Packagefile!
private var manifest: Manifest!

final class CoreTests: XCTestCase {

    func test1_packagefileParsing() {
        do {
            let packagefileData = try dummyPackagefilePath.read()
            packagefile = try Packagefile(from: packagefileData)
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }

    func test2_manifestParsing() {
        do {
            let manifestData = try dummyManifestPath.read()
            manifest = try Manifest(
                from: manifestData,
                at: dummyManifestPath,
                with: packagefile
            )
        } catch let error {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
