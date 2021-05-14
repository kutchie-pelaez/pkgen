import GraphViz
import PathKit

final class GraphRenderer {

    private let packagefilePath: Path

    private var externalNodes = [String]()
    private var internalNodes = [String]()

    public init(packagefilePath: Path) {
        self.packagefilePath = packagefilePath
    }

    // MARK: - Rendering graph based on dependencise

    public func render(to path: Path, completion: () -> ()) throws {
        let graph = try buildGraph()

        graph.render(using: .dot, to: .pdf) { result in

        }
    }

    private func buildGraph() throws -> Graph {
        var graph = Graph(directed: true)

        let root = Node("Root")
        graph.append(root)

        return graph
    }
}
