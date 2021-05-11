import Foundation
import SwiftCLI

public final class PackageGenCLI {

    private lazy var cli: CLI = {
        let cli = CLI(
            name: "pkgen",
            version: "0.0.0",
            commands: [
                GenerateCommand()
            ]
        )

        cli.helpCommand = nil

        return cli
    }()

    public init() { }
}



public extension PackageGenCLI {

    func execute(arguments: [String]? = nil) {
        let status: Int32
        if let arguments = arguments {
            status = cli.go(with: arguments)
        } else {
            status = cli.go()
        }

        exit(status)
    }
}
