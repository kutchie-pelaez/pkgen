struct Package: PrimitiveProtocol {

    private let hasDefaultLocalization: Bool
    private let hasPlatforms: Bool
    private let hasPKGConfig: Bool
    private let hasProviders: Bool
    private let hasProducts: Bool
    private let hasDependencies: Bool
    private let hasTargets: Bool
    private let hasSwiftLanguageVersions: Bool
    private let hasCLanguageStandard: Bool
    private let hasCXXLanguageStandard: Bool

    init(hasDefaultLocalization: Bool,
         hasPlatforms: Bool,
         hasPKGConfig: Bool,
         hasProviders: Bool,
         hasProducts: Bool,
         hasDependencies: Bool,
         hasTargets: Bool,
         hasSwiftLanguageVersions: Bool,
         hasCLanguageStandard: Bool,
         hasCXXLanguageStandard: Bool) {
        self.hasDefaultLocalization = hasDefaultLocalization
        self.hasPlatforms = hasPlatforms
        self.hasPKGConfig = hasPKGConfig
        self.hasProviders = hasProviders
        self.hasProducts = hasProducts
        self.hasDependencies = hasDependencies
        self.hasTargets = hasTargets
        self.hasSwiftLanguageVersions = hasSwiftLanguageVersions
        self.hasCLanguageStandard = hasCLanguageStandard
        self.hasCXXLanguageStandard = hasCXXLanguageStandard
    }

    private func argument(_ name: String, isLast: Bool) -> PrimitiveProtocol {
        "\(name): \(name)\(isLast ? "" : ",")"
            .indented(with: .tab)
            .newLine
    }

    private func isLast(for position: Int) -> Bool {
        let flags = [
            true, // Name is always presents
            hasDefaultLocalization,
            hasPlatforms,
            hasPKGConfig,
            hasProviders,
            hasProducts,
            hasDependencies,
            hasTargets,
            hasSwiftLanguageVersions,
            hasCLanguageStandard,
            hasCXXLanguageStandard
        ]

        if position == flags.count - 1 {
            return true
        }

        return flags[position + 1...flags.count - 1]
            .allSatisfy { !$0 }
    }

    var string: String {
        PropertyDeclaration(name: "package")
            .chain("Package")
            .parenthesis(type: .opened)
            .newLine
            .chain(argument("name", isLast: isLast(for: 0)))
            .chain(hasDefaultLocalization ? argument("defaultLocalization", isLast: isLast(for: 1)) : Empty())
            .chain(hasPlatforms ? argument("platforms", isLast: isLast(for: 2)) : Empty())
            .chain(hasPKGConfig ? argument("pkgConfig", isLast: isLast(for: 3)) : Empty())
            .chain(hasProviders ? argument("providers", isLast: isLast(for: 4)) : Empty())
            .chain(hasProducts ? argument("products", isLast: isLast(for: 5)) : Empty())
            .chain(hasDependencies ? argument("dependencies", isLast: isLast(for: 6)) : Empty())
            .chain(hasTargets ? argument("targets", isLast: isLast(for: 7)) : Empty())
            .chain(hasSwiftLanguageVersions ? argument("swiftLanguageVersions", isLast: isLast(for: 8)) : Empty())
            .chain(hasCLanguageStandard ? argument("cLanguageStandard", isLast: isLast(for: 9)) : Empty())
            .chain(hasCXXLanguageStandard ? argument("cxxLanguageStandard", isLast: isLast(for: 10)) : Empty())
            .newLine
            .parenthesis(type: .closed)
            .string
    }
}
