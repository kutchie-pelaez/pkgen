public enum ManifestProduct: Equatable {
    case executable(executable: Executable)
    case library(library: Library)
}
