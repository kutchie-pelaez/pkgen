@testable import Core
import XCTest
import PathKit

// MARK: - Fixture files helpers

private var fixturePackagefilePath = Path(#file).parent().parent().parent() + "Fixtures" + "Packagefile"
private var fixtureManifestPath = Path(#file).parent().parent().parent() + "Fixtures" + "package.yml"
private var packagefile: Packagefile!
private var manifest: Manifest!

// MARK: - Tests

final class CoreTests: XCTestCase {

    func test1_packagefileParsing() {
        do {
            let packagefileData = try fixturePackagefilePath.read()
            packagefile = try Packagefile(from: packagefileData)
        } catch let error {
            XCTAssert(
                false,
                error.localizedDescription
            )
        }
    }

    func test2_manifestParsing() {
        do {
            let manifestData = try fixtureManifestPath.read()
            manifest = try Manifest(
                from: manifestData,
                at: fixtureManifestPath,
                with: packagefile
            )
        } catch let error {
            XCTAssert(
                false,
                error.localizedDescription
            )
        }
    }

    func test3_comparingPackagefiles() {
        XCTAssertEqual(
            packagefile,
            Self.expectedPackagefile,
            "Packagefile from file differs from expected"
        )
    }

    func test4_comparingManifests() {
        XCTAssertEqual(
            manifest,
            Self.expectedManifest,
            "Manifest from file differs from expected"
        )
    }
}

// MARK: - Private

private extension CoreTests {

    static var expectedPackagefile = Packagefile(
        options: .init(
            swiftToolsVersion: "5.3",
            platforms: .init(
                iOS: "v14",
                macOS: "v10_13"
            )
        ),
        externalDependencies: [
            .github(
                .init(
                    path: "kylef/PathKit",
                    route: .branch("master")
                )
            ),
            .github(
                .init(
                    path: "jpsim/Yams",
                    route: .from("4.0.0")
                )
            )
        ]
    )

    static var expectedManifest = Manifest(
        swiftToolsVersion: "5.3",
        name: "Fixtures",
        platforms: .init(
            iOS: "v14",
            macOS: "v10_13"
        ),
        products: [
            .library(
                .init(
                    name: "Fixtures",
                    targets: [
                        "Fixtures"
                    ],
                    linking: .auto
                )
            )
        ],
        dependencies: [
            .external(
                .github(
                    .init(
                        path: "kylef/PathKit",
                        route: .branch("master")
                    )
                )
            ),
            .external(
                .github(
                    .init(
                        path: "jpsim/Yams",
                        route: .from("4.0.0")
                    )
                )
            ),
        ],
        targets: [
            .init(
                name: "Fixtures",
                dependencies: [
                    "PathKit",
                    "Yams"
                ]
            )
        ]
    )
}
