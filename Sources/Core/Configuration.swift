import PathKit

public struct Configuration: Decodable {
    let options: Options

    public struct Options: Decodable {
        let swiftToolsVersion: String
    }
}


public extension Configuration {

    static let configurationPath: Path = { .current + "Pkgenfile" }()
}
