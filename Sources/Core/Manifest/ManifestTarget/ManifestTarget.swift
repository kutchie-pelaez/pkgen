public enum ManifestTarget: Equatable {
    case binaryTarget(binaryTarget: BinaryTarget)
    case systemLibrary(systemLibrary: SystemLibrary)
    case target(target: Target)
    case testTarget(testTarget: Target)
}
