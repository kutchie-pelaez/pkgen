import Core

// MARK: - Empty Packagefile expectation

extension CoreTests {

    static let expectedEmptyPackagefile = Packagefile(
        swiftToolsVersion: "5.3",
        defaultLocalization: nil,
        platforms: nil,
        pkgConfig: nil,
        providers: nil,
        swiftLanguageVersions: nil,
        cLanguageStandard: nil,
        cxxLanguageStandard: nil,
        externalDependencies: nil
    )
}

// MARK: - Full Packagefile expectation

extension CoreTests {

    static let expectedFullPackagefile = Packagefile(
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
                    "b",
                ]
            ),
            .brew(
                [
                    "c",
                    "d",
                ]
            ),
        ],
        swiftLanguageVersions: [
            .v4,
            .v4_2,
            .v5,
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
}

// MARK: - Empty manifest with empty Packagefile expectation

extension CoreTests {

    static let expectedEmptyManifestWithEmptyPackagefile = Manifest(
        swiftToolsVersion: "5.3",
        name: "Fixtures",
        defaultLocalization: nil,
        platforms: nil,
        pkgConfig: nil,
        providers: nil,
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
        swiftLanguageVersions: nil,
        cLanguageStandard: nil,
        cxxLanguageStandard: nil
    )
}

// MARK: - Empty manifest with full Packagefile expectation

extension CoreTests {

    static let expectedEmptyManifestWithFullPackagefile = Manifest(
        swiftToolsVersion: "",
        name: "",
        defaultLocalization: nil,
        platforms: nil,
        pkgConfig: nil,
        providers: nil,
        products: nil,
        dependencies: nil,
        targets: nil,
        swiftLanguageVersions: nil,
        cLanguageStandard: nil,
        cxxLanguageStandard: nil
    )
}

// MARK: - Full manifest with empty Packagefile expectation

extension CoreTests {

    static let expectedFullManifestWithEmptyPackagefile = Manifest(
        swiftToolsVersion: "",
        name: "",
        defaultLocalization: nil,
        platforms: nil,
        pkgConfig: nil,
        providers: nil,
        products: nil,
        dependencies: nil,
        targets: nil,
        swiftLanguageVersions: nil,
        cLanguageStandard: nil,
        cxxLanguageStandard: nil
    )
}

// MARK: - Full manifest with full Packagefile expectation

extension CoreTests {

    static let expectedFullManifestWithFullPackagefile = Manifest(
        swiftToolsVersion: "",
        name: "",
        defaultLocalization: nil,
        platforms: nil,
        pkgConfig: nil,
        providers: nil,
        products: nil,
        dependencies: nil,
        targets: nil,
        swiftLanguageVersions: nil,
        cLanguageStandard: nil,
        cxxLanguageStandard: nil
    )
}
