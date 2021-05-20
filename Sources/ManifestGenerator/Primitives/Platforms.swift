import Core

struct Platforms: PrimitiveProtocol {

    private let platforms: Core.Platforms

    init(_ platforms: Core.Platforms) {
        self.platforms = platforms
    }

    private var iOSPlatformString: String? {
        guard let iOSVersion = platforms.iOS else { return nil }

        return ".iOS(.\(iOSVersion))"
    }

    private var macOSPlatformString: String? {
        guard let macOSVersion = platforms.macOS else { return nil }

        return ".macOS(.\(macOSVersion))"
    }

    private var tvOSPlatformString: String? {
        guard let tvOSVersion = platforms.tvOS else { return nil }

        return ".tvOS(.\(tvOSVersion))"
    }

    private var watchOSPlatformString: String? {
        guard let watchOSVersion = platforms.watchOS else { return nil }

        return ".watchOS(.\(watchOSVersion))"
    }

    private var body: String {
        var result = ""

        if let iOSPlatformString = iOSPlatformString {
            result.append(iOSPlatformString)
        }

        if let macOSPlatformString = macOSPlatformString {
            if !result.isEmpty {
                result.append(",\n")
            }
            result.append(macOSPlatformString)
        }

        if let tvOSPlatformString = tvOSPlatformString {
            if !result.isEmpty {
                result.append(",\n")
            }
            result.append(tvOSPlatformString)
        }

        if let watchOSPlatformString = watchOSPlatformString {
            if !result.isEmpty {
                result.append(",\n")
            }
            result.append(watchOSPlatformString)
        }

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
