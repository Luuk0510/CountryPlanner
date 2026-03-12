import Foundation
import Combine

final class CountriesListViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    
    @Published var isLoading: Bool = false
    
    @Published var errorMessage: String? = nil
    
    private let apiService: CountriesApiService
    
    init(apiService: CountriesApiService = CountriesApiService()) {
        self.apiService = apiService
    }
    
    @MainActor
    func loadCountries() async {
        // Prevent overlapping requests when .task and retry button fire close together.
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        
        // Always clear the spinner, even if fetch or decode throws.
        defer { isLoading = false }
        
        do {
            let dtoList = try await apiService.fetchCountries()
            
            countries = dtoList
                .map {
                    Country(
                        id: $0.cca3,
                        name: $0.name.common,
                        flagUrl: $0.flags.png
                    )
                }
                .sorted { $0.name < $1.name }
        } catch {
            errorMessage = "Could not load countries."
        }
    }
}
