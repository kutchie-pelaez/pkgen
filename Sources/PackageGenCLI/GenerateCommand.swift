import SwiftCLI

final class GenerateCommand: Command {

    let name = "generate"

    let shortDescription = "Generates package files based on manifests"

    @Key("-c", "--configuration-path", description: "")
    var configurationPath: String?

    func execute() throws {

    }
}
