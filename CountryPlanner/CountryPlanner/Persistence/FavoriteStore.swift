import Foundation

protocol FavoritesStoring {
    func load() -> Set<String>
    func save(_ ids: Set<String>)
}

final class FavoritesStore: FavoritesStoring {
    private let key = "nl.avans.countryplanner.favoriteByCountryIds"
    

    func load() -> Set<String> {
        let arr = UserDefaults.standard.array(forKey: key) as? [String] ?? []
        return Set(arr)
    }

    func save(_ ids: Set<String>) {
        UserDefaults.standard.set(Array(ids), forKey: key)
    }
}
