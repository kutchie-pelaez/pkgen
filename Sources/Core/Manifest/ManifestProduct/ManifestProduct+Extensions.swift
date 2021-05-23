// MARK: - Decodable

extension ManifestProduct: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case targets
        case linking
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw ManifestProductDecodingError.noType
        }

        guard let name = try? container.decode(String.self, forKey: .name) else {
            throw ManifestProductDecodingError.noName
        }

        guard let targets = try? container.decode([String].self, forKey: .targets) else {
            throw ManifestProductDecodingError.noTargets
        }

        guard !targets.isEmpty else {
            throw ManifestProductDecodingError.emptyTargets
        }

        switch stringType {
        case "executable":
            self = .executable(
                executable: .init(
                    name: name,
                    targets: targets
                )
            )

        case "library":
            let linking: Library.LinkingType

            if let decodedLinkingType = try? container.decode(String.self, forKey: .linking) {
                if let linkingType = Library.LinkingType(rawValue: decodedLinkingType) {
                    linking = linkingType
                } else {
                    throw ManifestProductDecodingError.invalidLinking
                }
            } else {
                linking = .auto
            }

            self = .library(
                library: .init(
                    name: name,
                    targets: targets,
                    linking: linking
                )
            )

        default:
            throw ManifestProductDecodingError.invalidType
        }
    }
}

// MARK: - ManifestProductDecodingError

extension ManifestProduct {

    public enum ManifestProductDecodingError: Error {
        case noType
        case noName
        case noTargets
        case emptyTargets
        case invalidLinking
        case invalidType
    }
}
