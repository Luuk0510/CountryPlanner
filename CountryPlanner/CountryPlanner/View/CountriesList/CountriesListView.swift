import SwiftUI

struct CountriesListView: View {
    
    @StateObject private var countriesVM = CountriesListViewModel()
    @EnvironmentObject private var favoritesVM: FavoritesViewModel
    
    @State private var searchText: String = ""
    
    private enum Strings {
        static let title = "Countries"
        static let loading = "Loading..."
        static let retry = "Retry"
        static let searchPrompt = "Search countries"
    }
    

    private enum Layout {
        static let screenPadding: CGFloat = 16
        static let spacing: CGFloat = 3
        static let retryCornerRadius: CGFloat = 8
        static let rowSpacing: CGFloat = 12
        static let rowPadding: CGFloat = 12
        static let rowCornerRadius: CGFloat = 14
        static let favoriteButtonSize: CGFloat = 28
    }
    
    private enum Icons {
        static let favorite = "star"
        static let favoriteFilled = "star.fill"
    }
    

    var body: some View {
        content
            .navigationTitle(Strings.title)
            .searchable(text: $searchText, prompt: Strings.searchPrompt)
            .background(.ultraThinMaterial)
            .task {
                await countriesVM.loadCountries()
            }
    }
    
    private var content: some View {
        VStack(spacing: Layout.spacing) {
            if countriesVM.isLoading {
                ProgressView(Strings.loading)
            } else if let error = countriesVM.errorMessage {
                errorState(error)
            } else {
                listContent
            }
        }
    }

    private func errorState(_ message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .foregroundStyle(.secondary)
            
            Button(Strings.retry) {
                Task { await countriesVM.loadCountries() }
            }
            .buttonStyle(.borderedProminent)
            .background(Color.white)
            .cornerRadius(Layout.retryCornerRadius)
        }
        .padding(.horizontal, Layout.screenPadding)
    }

    private var listContent: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Layout.spacing) {
                ForEach(filteredCountries) { country in
                    row(for: country)
                        .padding(.horizontal, Layout.screenPadding)
                        .padding(.vertical, Layout.spacing)
                }
            }
        }
    }
    
    private func row(for country: Country) -> some View {
        HStack(spacing: Layout.rowSpacing) {
            NavigationLink {
                CountryDetailView(country: country)
            } label: {
                CountryRowView(country: country)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                favoritesVM.toggle(country.favoriteId)
            } label: {
                Image(systemName: favoriteIcon(for: country))
                    .foregroundStyle(.yellow)
                    .frame(width: Layout.favoriteButtonSize, height: Layout.favoriteButtonSize)
            }
            .buttonStyle(.plain)
        }
        .padding(Layout.rowPadding)
        .background(Color.white)
        .cornerRadius(Layout.rowCornerRadius)
    }
    

    private var filteredCountries: [Country] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return countriesVM.countries
            .filter { query.isEmpty || $0.name.localizedCaseInsensitiveContains(query) }
            .sorted { a, b in
                let aFav = favoritesVM.isFavorite(a.favoriteId)
                let bFav = favoritesVM.isFavorite(b.favoriteId)
                // Sort favorites to the top, then keep alphabetical order within each group.
                if aFav != bFav { return aFav && !bFav }
                return a.name < b.name
            }
    }
    
    private func favoriteIcon(for country: Country) -> String {
        favoritesVM.isFavorite(country.favoriteId) ? Icons.favoriteFilled : Icons.favorite
    }
}

#Preview {
    NavigationStack {
        CountriesListView()
            .environmentObject(FavoritesViewModel())
    }
}
