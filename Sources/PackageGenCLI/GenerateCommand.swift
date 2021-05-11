import SwiftCLI
import PathKit
import Core
import Foundation

final class GenerateCommand: Command {

    let name = "generate"
    let shortDescription = "Generates package files based on manifests"

    func execute() throws {
        stdout.print(Configuration.configurationPath.string)
    }
}
