import Core

struct Platforms: PrimitiveProtocol {

    private let platforms: Core.Platforms
    private let isLastArgument: Bool

    init(_ platforms: Core.Platforms,
         isLastArgument: Bool) {
        self.platforms = platforms
        self.isLastArgument = isLastArgument
    }

    private var iOSPlatformString: String? {
        guard let iOSVersion = platforms.iOS else { return nil }

        return ".iOS(.\(iOSVersion))"
    }

    private var macOSPlatformString: String? {
        guard let macOSVersion = platforms.macOS else { return nil }

        return ".macOS(.\(macOSVersion))"
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

        return result
    }

    var string: String {
        """
        platforms: [
            \(body)
        ]\(isLastArgument ? "" : ",")
        """
    }
}
