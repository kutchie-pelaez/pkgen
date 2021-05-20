import Foundation

public enum CStandard: String, Decodable, Equatable {
    case c89, c90, c99, c11, gnu89, gnu90, gnu99, gnu11, iso9899_1990, iso9899_199409, iso9899_1999, iso9899_2011
}
