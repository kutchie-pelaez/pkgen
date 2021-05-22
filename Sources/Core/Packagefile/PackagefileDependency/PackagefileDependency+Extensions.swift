// MARK: - Decodable

extension PackagefileDependency: Decodable {

    private enum CodingKeys: String, CodingKey {
        case github
    }

    public init(from decoder: Decoder) throws {
        fatalError()
    }
}
