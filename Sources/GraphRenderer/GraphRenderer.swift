import GraphViz
import PathKit
import Foundation
import Core

public final class GraphRenderer {

    private let packagefilePath: Path
    private let manifestRootSearchinigPath: Path
    private var externalNodes = [String]()
    private var internalNodes = [String]()
    private var relations = [String: [String]]()

    public init(packagefilePath: Path,
                manifestRootSearchinigPath: Path) {
        self.packagefilePath = packagefilePath
        self.manifestRootSearchinigPath = manifestRootSearchinigPath
    }

    // MARK: - Rendering graph based on dependencise

    public func render(to path: Path) throws {
        try populateDependenciesAndRelations()

        let semaphore = DispatchSemaphore(value: 0)
        var renderError: Swift.Error?

        try buildGraph().render(using: .dot, to: .pdf) { result in
            switch result {
            case let .success(data):
                do {
                    try path.parent().mkpath()
                    try path.write(data)
                    renderError = nil
                } catch let error {
                    renderError = error
                }

            case let .failure(error):
                renderError = error
            }

            semaphore.signal()
        }

        semaphore.wait()

        if let error = renderError {
            throw error
        }
    }

    private func populateDependenciesAndRelations() throws {
        
    }

    private func f() {

    }

    private func buildGraph() throws -> Graph {
        var graph = Graph(directed: true)
        var nodes = [Node]()
        var edges = [Edge]()

        for externalNode in externalNodes {
            guard !nodes.contains(where: { $0.id == externalNode }) else { continue }

            let node = Node(externalNode)
            nodes.append(node)
        }

        for internalNode in internalNodes {
            guard !nodes.contains(where: { $0.id == internalNode }) else { continue }

            let node = Node(internalNode)
            nodes.append(node)
        }

        for relation in relations.keys {
            guard let dependencies = relations[relation] else { continue }

            for dependency in dependencies {
                guard let fromNode = nodes.first(where: { $0.id == relation }),
                      let toNode = nodes.first(where: { $0.id == dependency }) else {
                    continue
                }

                edges.append(.init(from: fromNode, to: toNode))
            }
        }

        graph.append(contentsOf: edges)

        return graph
    }
}
