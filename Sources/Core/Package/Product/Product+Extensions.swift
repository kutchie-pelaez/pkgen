// MARK: - Decodable

extension Product: Decodable {

    private enum CodingKeys: String, CodingKey {
        case type
        case name
        case targets
        case linking
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let stringType = try? container.decode(String.self, forKey: .type) else {
            throw ProductDecodingError.noProductTypeSpecified
        }

        guard let targets = try? container.decode([String].self, forKey: .targets) else {
            throw ProductDecodingError.noTargetsSpecified
        }

        guard !targets.isEmpty else {
            throw ProductDecodingError.emptyTargetsProvided
        }

        guard let name = try? container.decode(String.self, forKey: .name) else {
            throw ProductDecodingError.noNameSpecified
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
                    throw ProductDecodingError.invalidLibraryLinkingType
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
            throw ProductDecodingError.invalidProductType
        }
    }
}

// MARK: - ProductDecodingError

extension Product {

    public enum ProductDecodingError: Error {
        case noTargetsSpecified
        case noNameSpecified
        case emptyTargetsProvided
        case noProductTypeSpecified
        case invalidProductType
        case invalidLibraryLinkingType
    }
}
