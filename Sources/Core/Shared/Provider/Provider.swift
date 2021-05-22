public enum Provider: Equatable {
    case apt(packages: [String])
    case brew(packages: [String])
    case yum(packages: [String])
}
