import Foundation

struct CountryDTO: Codable {
    let cca3: String
    let name: NameDTO
    let flags: FlagsDTO
    
    struct NameDTO: Codable {
        let common: String
    }
    
    struct FlagsDTO: Codable {
        let png: String
    }
}
