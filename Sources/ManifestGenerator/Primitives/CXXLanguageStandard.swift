import Core

struct CXXLanguageStandard: PrimitiveProtocol {

    private let standard: CXXStandard

    init(_ standard: CXXStandard) {
        self.standard = standard
    }

    var string: String {
        ".\(standard.rawValue)"
    }
}
