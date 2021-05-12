enum Constants {
    static var defaultConfigurationFileFullname: String { defaultConfigurationFileName + (defaultConfigurationFileExtension.isEmpty ? "" : ".") + defaultConfigurationFileExtension }
    static let defaultConfigurationFileName = "Packagefile"
    static let defaultConfigurationFileExtension = ""

    static var defaultManifestFileFullname: String { defaultManifestFileName + (defaultManifestFileExtension.isEmpty ? "" : ".") + defaultManifestFileExtension }
    static let defaultManifestFileName = "manifest"
    static let defaultManifestFileExtension = "yml"
}
