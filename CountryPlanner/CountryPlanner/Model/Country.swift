import Foundation

struct Country: Identifiable, Equatable {
    let id: String
    let name: String
    let flagUrl: String
}

extension Country {
    var favoriteId: String {
        id
    }
}
