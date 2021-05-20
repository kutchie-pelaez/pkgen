import Core

struct Platforms: PrimitiveProtocol {

    private let platforms: Core.Platforms

    init(_ platforms: Core.Platforms) {
        self.platforms = platforms
    }

    private enum PlatformType: String {
        case iOS, macOS, tvOS, watchOS
    }

    private func specificPlatformString(for platformType: PlatformType, version: String?) -> String? {
        guard let version = version else { return nil }

        return ".\(platformType.rawValue)(.\(version))"
    }

    private var body: String {
        var result = ""

        func appendVersionToResultIfNeeded(_ version: String?) {
            guard let version = version else { return }

            if !result.isEmpty {
                result.append(",\n")
            }
            
            result.append(version)
        }

        appendVersionToResultIfNeeded(specificPlatformString(for: .iOS, version: platforms.iOS))
        appendVersionToResultIfNeeded(specificPlatformString(for: .macOS, version: platforms.macOS))
        appendVersionToResultIfNeeded(specificPlatformString(for: .tvOS, version: platforms.tvOS))
        appendVersionToResultIfNeeded(specificPlatformString(for: .watchOS, version: platforms.watchOS))

        return result
            .indented(with: .tab)
            .string
    }

    var string: String {
        """
        [
        \(body)
        ]
        """
    }
}
