import Core

// MARK: - Empty Packagefile expectation

extension CoreTests {

    static let expectedEmptyPackagefile = Packagefile(
        swiftToolsVersion: nil,
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
        swiftToolsVersion: nil,
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

// MARK: - Empty manifest with empty Packagefile expectation

extension CoreTests {

    static let expectedEmptyManifestWithEmptyPackagefile = Manifest(
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
