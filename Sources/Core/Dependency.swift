import Foundation

public enum Dependency {
    case local(LocalDependency)
    case external(ExternalDependency)
}
