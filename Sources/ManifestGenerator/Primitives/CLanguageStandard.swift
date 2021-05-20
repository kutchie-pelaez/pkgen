import Core

struct CLanguageStandard: PrimitiveProtocol {

    private let standard: CStandard

    init(_ standard: CStandard) {
        self.standard = standard
    }

    var string: String {
        ".\(standard.rawValue)"
    }
}
