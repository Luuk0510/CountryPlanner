import Combine
import Foundation

final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favoriteIds: Set<String> = []
    
    private let store: FavoritesStoring
    
    init(store: FavoritesStoring = FavoritesStore()) {
        self.store = store
        self.favoriteIds = store.load()
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    func toggle(_ id: String) {
        if favoriteIds.contains(id) {
            favoriteIds.remove(id)
        } else {
            favoriteIds.insert(id)
        }
        store.save(favoriteIds)
    }
}
