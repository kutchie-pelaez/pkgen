import Core
import PathKit
import XCTest

// MARK: - Packagefile tests helpers

extension CoreTests {
    
    func testPackagefileParsing(at path: Path, saveTo packagefile: inout Packagefile?) {
        do {
            let packagefileData = try path.read()
            packagefile = try Packagefile(from: packagefileData)
        } catch let error {
            XCTAssert(
                false,
                error.localizedDescription
            )
        }
    }

    func testPackagefilesComparing(_ packagefile: Packagefile?, _ expectedPackagefile: Packagefile) {
        if let packagefile = packagefile {
            XCTAssertEqual(
                packagefile,
                expectedPackagefile,
                "Packagefile from file differs from expected"
            )
        } else {
            XCTAssert(
                false,
                "Testing packagefile is nil"
            )
        }
    }
}

// MARK: - Manifest tests helpers

extension CoreTests {

    func testManifestParsing(at path: Path, with packagefile: Packagefile?, saveTo manifest: inout Manifest?) {
        if let packagefile = packagefile {
            do {
                let manifestData = try path.read()
                manifest = try Manifest(
                    from: manifestData,
                    at: path,
                    with: packagefile
                )
            } catch let error {
                XCTAssert(
                    false,
                    error.localizedDescription
                )
            }
        } else {
            XCTAssert(
                false,
                "Packagefile is nil"
            )
        }
    }

    func testManifestsComparing(_ manifest: Manifest?, _ expectedManifest: Manifest) {
        if let manifest = manifest {
            XCTAssertEqual(
                manifest,
                expectedManifest,
                "Full manifest from file differs from expected"
            )
        } else {
            XCTAssert(
                false,
                "Testing manifest is nil"
            )
        }
    }
}
