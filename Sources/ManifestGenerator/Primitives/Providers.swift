import Core

struct Providers: PrimitiveProtocol {

    private let providers: [PackageProvider]

    init(_ providers: [PackageProvider]) {
        self.providers = providers
    }

    private enum ProviderType: String {
        case apt, brew, yum
    }

    private func providerString(for provider: PackageProvider, isLast: Bool) -> String {
        switch provider {
        case let .apt(packages): return concreteProviderString(for: .apt, with: packages, isLast: isLast)
        case let .brew(packages): return concreteProviderString(for: .brew, with: packages, isLast: isLast)
        case let .yum(packages): return concreteProviderString(for: .yum, with: packages, isLast:isLast)
        }
    }

    private func concreteProviderString(for providerType: ProviderType, with packages: [String], isLast: Bool) -> String {
        """
        .\(providerType.rawValue)(
            [
            \(packages.joined(separator: "\n").indented(with: .tab))
            ]
        )\(isLast ? "" : ",")
        """
    }

    private var body: String {
        var result = ""

        for (index, provider) in providers.enumerated() {
            result += providerString(for: provider, isLast: index == providers.count - 1)
        }

        return result
    }

    var string: String {
        """
        [
        \(body)
        ]
        """
    }
}
