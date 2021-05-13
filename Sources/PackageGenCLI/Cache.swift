import Foundation
import PathKit
import CommonCrypto

final class Cache {

    static let defaultCachePath: Path = .home + ".pkgen" + "cache" + "pkgen_cache.json"

    let path: Path
    private lazy var cacheContent: [String: String] = {
        guard let cacheData = try? path.read(),
              let json = (try? JSONSerialization.jsonObject(with: cacheData, options: [])) as? [String: String] else {
            return [:]
        }

        return json
    }()

    init(_ path: Path = Cache.defaultCachePath) {
        self.path = path
    }

    func createCacheFile(from generatedPackagePaths: [Path]) throws {
        var result = cacheContent

        for path in generatedPackagePaths {
            let url = path.url

            guard let contentModificationDate = try url.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate else { throw CacheError.failedToRetrieveContentModificationDate }

            result[path.string] = String(Int(contentModificationDate.timeIntervalSince1970))
        }

        let jsonData = try JSONSerialization.data(withJSONObject: result, options: [.prettyPrinted])
        try path.parent().mkpath()
        try path.write(jsonData)
    }

    func isFileSameSinceLastGeneration(at path: Path) -> Bool {
        let url = path.url

        guard let contentModificationDate = try? url.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate else { return false }

        guard let contentModificationDateFromCache = cacheContent[path.string] else { return false }

        return String(Int(contentModificationDate.timeIntervalSince1970)) == contentModificationDateFromCache
    }

    // MARK: - Cache errors

    enum CacheError: Error {
        case failedToRetrieveContentModificationDate
    }
}
