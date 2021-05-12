@testable import Core
import XCTest
import PathKit

// MARK: - Dummy files helpers

private var dummyPackagefilePath = Path(#file).parent() + "DummyPackagefile"
private var dummyManifestPath = Path(#file).parent() + "dummy_package.yml"
private var packagefile: Packagefile!
private var manifest: Manifest!

// MARK: - Tests

final class CoreTests: XCTestCase {

    func test1_packagefileParsing() {
        do {
            let packagefileData = try dummyPackagefilePath.read()
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
            let manifestData = try dummyManifestPath.read()
            manifest = try Manifest(
                from: manifestData,
                at: dummyManifestPath,
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
            Self.expectedDymmyPackagefile,
            "Packagefile from file differs from expected"
        )
    }

    func test4_comparingManifests() {
        XCTAssertEqual(
            manifest,
            Self.expectedDymmyManifest,
            "Manifest from file differs from expected"
        )
    }
}

// MARK: - Private

private extension CoreTests {

    static var expectedDymmyPackagefile = Packagefile(
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

    static var expectedDymmyManifest = Manifest(
        swiftToolsVersion: "5.3",
        name: "CoreTests",
        platforms: .init(
            iOS: "v14",
            macOS: "v10_13"
        ),
        products: [
            .library(
                .init(
                    name: "CoreTests",
                    targets: [
                        "CoreTests"
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
                name: "CoreTests",
                dependencies: [
                    "PathKit",
                    "Yams"
                ]
            )
        ]
    )
}
