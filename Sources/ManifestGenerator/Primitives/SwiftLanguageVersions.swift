import Core

struct SwiftLanguageVersions: PrimitiveProtocol {

    private let swiftVersions: [SwiftVersion]

    init(_ swiftVersions: [SwiftVersion]) {
        self.swiftVersions = swiftVersions
    }

    private var body: String {
        var result = ""

        for swiftVersion in swiftVersions {
            if !result.isEmpty {
                result.append(",\n")
            }

            result.append(swiftVersion.rawValue)
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
