import SwiftCLI
import GraphKit
import PathKit
import Rainbow

final class GraphCommand {

    @Param
    var path: String

    @Param
    var packagefile: String?

    // MARK: - Routable

    let name = "graph"

    let shortDescription = "Render dependencies graph to specified path"
}

// MARK: - Command

extension GraphCommand: Command {

    func execute() throws {
        let renderer = DependenciesGraphRenderer(packagefilePath: Path(packagefile ?? ""), manifestRootSearchinigPath: "")
        do {
            try renderer.render(to: pathToRender)
            stdout.print("✅ Graph successfully rendered at \(pathToRender)".green)
        } catch let error {
            stdout.print("Failed to rendered graph at \(pathToRender)".red)
            throw error
        }
    }
}

// MARK: - Private

private extension GraphCommand {

    var pathToRender: Path {
        Path(path) + "graph.pdf"
    }
}
