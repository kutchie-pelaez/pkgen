@testable import PackageGenCLI
import XCTest
import PathKit
import Core

private let tmpFileAPath = Path(#file).parent().parent().parent() + "Fixtures" + "tmp_a"
private let tmpFileBPath = Path(#file).parent().parent().parent() + "Fixtures" + "tmp_b"
private var allTmpFilePaths: [Path] { [tmpFileAPath, tmpFileBPath] }
private let cachePath = Path(#file).parent().parent().parent() + "Fixtures" + "cache.json"
private let cache = Cache(cachePath)
private var tmpFilesCachingTimestamp: String?

// MARK: - Tests

final class CacheTests: XCTestCase {

    func test1_cacheFileIsNotEmpty() {
        do {
            try createTmpFiles()
            try cache.createCacheFile(from: allTmpFilePaths)

            tmpFilesCachingTimestamp = String(Int(Date().timeIntervalSince1970))

            guard var cacheString = cacheString else { return XCTAssert(false) }

            cacheString = cacheString.trimmingCharacters(in: ["\n"])

            XCTAssert(!cacheString.isEmpty)
        } catch let error {
            clear()
            XCTAssert(false, error.localizedDescription)
        }
    }

    func test2_cacheFilesCorrectness() {
        do {
            let cacheData = try cachePath.read()

            guard let cacheDict = (try JSONSerialization.jsonObject(with: cacheData, options: [])) as? [String: String] else { return XCTAssert(false) }

            guard let tmpFileACachingTimestamp = cacheDict[tmpFileAPath.string],
                  let tmpFileBCachingTimestamp = cacheDict[tmpFileAPath.string] else {
                return XCTAssert(false)
            }

            // Testing timestampts correctness

            XCTAssert(tmpFileACachingTimestamp == tmpFilesCachingTimestamp)
            XCTAssert(tmpFileBCachingTimestamp == tmpFilesCachingTimestamp)

            // Testing cache's isFileSameSinceLastGeneration(at:)

            let expectation = expectation(description: "isFileSameSinceLastGeneration(at:) expectation")

            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1100)) {
                defer {
                    self.clear()
                }

                do {
                    try tmpFileAPath.write("AA")

                    guard let tmpFileALastModificationTimestamp = self.lastModificationTimestampString(for: tmpFileAPath),
                          let tmpFileBLastModificationTimestamp = self.lastModificationTimestampString(for: tmpFileBPath) else {
                        return
                    }

                    XCTAssert(tmpFileALastModificationTimestamp != tmpFileACachingTimestamp)
                    XCTAssert(tmpFileBLastModificationTimestamp == tmpFileBCachingTimestamp)

                    expectation.fulfill()
                } catch let error {
                    XCTAssert(false, error.localizedDescription)
                }
            }

            waitForExpectations(timeout: 2)
        } catch let error {
            clear()
            XCTAssert(false, error.localizedDescription)
        }
    }
}

// MARK: - Private

private extension CacheTests {

    var cacheString: String? {
        guard let cacheData = try? cachePath.read() else { return nil }

        return String(data: cacheData, encoding: .utf8)
    }

    func createTmpFiles() throws {
        try tmpFileAPath.write("A")
        try tmpFileBPath.write("B")
    }

    func clear() {
        try? removeTmpFile()
        try? removeCacheFile()
    }

    func removeTmpFile() throws {
        try tmpFileAPath.delete()
        try tmpFileBPath.delete()
    }

    func removeCacheFile() throws {
        try cachePath.delete()
    }

    func lastModificationTimestampString(for path: Path) -> String? {
        guard let contentModificationDate = (try? path.url.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate else { return nil }

        return String(Int(contentModificationDate.timeIntervalSince1970))
    }
}
