import Foundation

public enum Product: Decodable {
    case executable(Executable)
    case library(Library)

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case executable, library, targets, linking
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let targets = try? container.decode([String].self, forKey: .executable),
              !targets.isEmpty else {
            throw ProductDecodingError.noTargetsSpecified
        }

        if let executableName = try? container.decode(String.self, forKey: .executable) {
            self = .executable(.init(name: executableName, targets: targets))
        } else if let libraryName = try? container.decode(String.self, forKey: .library) {
            let linking: Library.Linking
            let linkingString = try? container.decode(String.self, forKey: .linking)
            if let linkingString = linkingString,
               let linkingFromString = Library.Linking(rawValue: linkingString) {
                linking = linkingFromString
            } else {
                linking = .static
            }
            self = .library(.init(name: libraryName, targets: targets, linking: linking))
        } else {
            throw ProductDecodingError.invalidProductType
        }
    }

    // MARK: - Decoding errors

    public enum ProductDecodingError: Error {
        case invalidProductType
        case noTargetsSpecified
    }
}

