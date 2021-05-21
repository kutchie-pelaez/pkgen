@testable import Core
import XCTest
import PathKit

// MARK: - Fixture files helpers

private let fixturePackagefilePath = Path(#file).parent().parent().parent() + "Fixtures" + "Packagefile"
private let fixtureFullManifestPath = Path(#file).parent().parent().parent() + "Fixtures" + "package_full.yml"
private let fixtureEmptyManifestPath = Path(#file).parent().parent().parent() + "Fixtures" + "package_empty.yml"
private var packagefile: Packagefile!
private var manifest: Manifest!
private var fullManifest: Manifest!
private var emptyManifest: Manifest!

// MARK: - Tests

final class CoreTests: XCTestCase {

    // Packagefile

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

    func test2_comparingPackagefiles() {
        XCTAssertEqual(
            packagefile,
            Self.expectedPackagefile,
            "Packagefile from file differs from expected"
        )
    }

    // Full manifest

    func test3_fullManifestParsing() {
        do {
            let fullManifestData = try fixtureFullManifestPath.read()
            fullManifest = try Manifest(
                from: fullManifestData,
                at: fixtureFullManifestPath,
                with: packagefile
            )
        } catch let error {
            XCTAssert(
                false,
                error.localizedDescription
            )
        }
    }

    func test4_comparingFullManifests() {
        XCTAssertEqual(
            fullManifest,
            Self.expectedFullManifest,
            "Full manifest from file differs from expected"
        )
    }

    // Empty manifest

    func test5_emptyManifestParsing() {
        do {
            let emptyManifestData = try fixtureEmptyManifestPath.read()
            emptyManifest = try Manifest(
                from: emptyManifestData,
                at: fixtureEmptyManifestPath,
                with: packagefile
            )
        } catch let error {
            XCTAssert(
                false,
                error.localizedDescription
            )
        }
    }

    func test6_comparingEmptyManifests() {
        XCTAssertEqual(
            emptyManifest,
            Self.expectedEmptyManifest,
            "Empty manifest from file differs from expected"
        )
    }
}

// MARK: - Private

private extension CoreTests {

    static var expectedPackagefile = Packagefile(
        swiftToolsVersion: "5.3",
        defaultLocalization: "en_US",
        platforms: .init(
            iOS: "v14",
            macOS: "v10_13",
            tvOS: "v14",
            watchOS: "v7"
        ),
        pkgConfig: "pkg_config_value",
        providers: [
            .apt(
                [
                    "a",
                    "b"
                ]
            ),
            .brew(
                [
                    "c",
                    "d"
                ]
            )
        ],
        swiftLanguageVersions: [
            .v4,
            .v4_2,
            .v5
        ],
        cLanguageStandard: .c99,
        cxxLanguageStandard: .cxx98,
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

    static var expectedFullManifest = Manifest(
        swiftToolsVersion: "5.2",
        name: "FullPackage",
        defaultLocalization: "fr_FR",
        platforms: .init(
            iOS: "v13",
            macOS: "v10_12"
        ),
        pkgConfig: "custom_pkg_config",
        providers: [
            .yum(
                [
                    "x",
                    "z"
                ]
            )
        ],
        products: [], // ???
        dependencies: [], // ???
        targets: [], // ???
        swiftLanguageVersions: [
            .v5
        ],
        cLanguageStandard: .c11,
        cxxLanguageStandard: .cxx14
    )

    static var expectedEmptyManifest = Manifest(
        swiftToolsVersion: "5.3",
        name: "Fixtures",
        defaultLocalization: "en_US",
        platforms: .init(
            iOS: "v14",
            macOS: "v10_13",
            tvOS: "v14",
            watchOS: "v7"
        ),
        pkgConfig: "pkg_config_value",
        providers: [
            .apt(
                [
                    "a",
                    "b"
                ]
            ),
            .brew(
                [
                    "c",
                    "d"
                ]
            )
        ],
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
        dependencies: nil,
        targets: [
            .init(
                name: "Fixtures",
                dependencies: []
            )
        ],
        swiftLanguageVersions: [
            .v4,
            .v4_2,
            .v5
        ],
        cLanguageStandard: .c99,
        cxxLanguageStandard: .cxx98
    )
}
