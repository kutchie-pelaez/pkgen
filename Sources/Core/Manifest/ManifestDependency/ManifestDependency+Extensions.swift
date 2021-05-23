// MARK: - Decodable

extension ManifestDependency: Decodable {

    private enum CodingKeys: String, CodingKey {
        case path
        case url
        case name
        case branch
        case exact
        case revision
        case upToNextMajor
        case upToNextMinor
        case from
        case to
        case upTo
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let name = try? container.decode(String.self, forKey: .name)

        if let path = try? container.decode(String.self, forKey: .path) {
            self = .local(
                local: .init(
                    path: path,
                    name: name
                )
            )
        } else if let url = try? container.decode(String.self, forKey: .url) {
            let requirement: Remote.Requirement

            if let from = try? container.decode(String.self, forKey: .from) {
                if let to = try? container.decode(String.self, forKey: .to) {
                    requirement = .closedRange(from: from, to: to)
                } else if let upTo = try? container.decode(String.self, forKey: .upTo) {
                    requirement = .range(from: from, upTo: upTo)
                } else {
                    requirement = .from(version: from)
                }
            } else if let branch = try? container.decode(String.self, forKey: .branch) {
                requirement = .branch(name: branch)
            } else if let exact = try? container.decode(String.self, forKey: .exact) {
                requirement = .exact(version: exact)
            } else if let revision = try? container.decode(String.self, forKey: .revision) {
                requirement = .revision(revision: revision)
            } else if let upToNextMajor = try? container.decode(String.self, forKey: .upToNextMajor) {
                requirement = .upToNextMajor(version: upToNextMajor)
            } else if let upToNextMinor = try? container.decode(String.self, forKey: .upToNextMinor) {
                requirement = .upToNextMinor(version: upToNextMinor)
            } else {
                throw ManifestDependencyDecodingError.invalidRemoteRequirement
            }

            self = .remote(
                remote: .init(
                    url: url,
                    requirement: requirement,
                    name: name
                )
            )
        } else {
            throw ManifestDependencyDecodingError.invalidType
        }
    }
}

// MARK: ManifestDependencyDecodingError

extension ManifestDependency {

    public enum ManifestDependencyDecodingError: Error {
        case invalidType
        case invalidRemoteRequirement
    }
}
