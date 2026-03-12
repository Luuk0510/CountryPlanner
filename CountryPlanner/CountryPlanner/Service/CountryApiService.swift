import Foundation

final class CountriesApiService {

    private let urlString = "https://restcountries.com/v3.1/all?fields=name,cca3,flags"
    

    func fetchCountries() async throws -> [CountryDTO] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        

        let (data, response) = try await URLSession.shared.data(from: url)
       

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        

        // Surface HTTP failures explicitly instead of turning them into decode errors.
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([CountryDTO].self, from: data)
    }
}
