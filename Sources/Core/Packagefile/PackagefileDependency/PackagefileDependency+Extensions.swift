// MARK: - Decodable

extension Packagefile.PackagefileDependency: Decodable {

    private enum CodingKeys: String, CodingKey {
        case dummy
    }

    public init(from decoder: Decoder) throws {
        fatalError()
    }
}

// MARK: - PackagefileDependencyDecodingError

extension Packagefile.PackagefileDependency {

    public enum PackagefileDependencyDecodingError: Error {
        case dummy
    }
}
