import SwiftUI

@main
struct CountryPlannerApp: App {
    @StateObject private var countryPlansVM = CountryPlansViewModel()
    @StateObject private var favoritesVM = FavoritesViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(countryPlansVM)
                .environmentObject(favoritesVM)
        }
    }
}
