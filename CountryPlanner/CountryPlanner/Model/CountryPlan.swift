import Foundation

struct CountryPlan: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let countryId: String
    let countryName: String
    
    var startDate: Date
    var endDate: Date
    let imageName: String
    var budget: Double
    var peopleCount: Int
    
    var notes: String
    var rating: Int?
    

    init(
        id: UUID = UUID(),
        countryId: String,
        countryName: String,
        imageName: String,
        startDate: Date = Date(),
        endDate: Date = Date(),
        budget: Double = 0,
        peopleCount: Int = 1,
        notes: String = "",
        rating: Int? = nil
    ) {
        self.id = id
        self.countryId = countryId
        self.countryName = countryName
        self.startDate = startDate
        self.imageName = imageName
        self.endDate = endDate
        self.budget = budget
        self.peopleCount = peopleCount
        self.notes = notes
        self.rating = rating
    }
}


extension CountryPlan {
    var isTripOver: Bool {
        let todayStart = Calendar.current.startOfDay(for: Date())
        return endDate < todayStart
    }
}

extension CountryPlan {
    func formattedBudget(currencyCode: String? = Locale.current.currency?.identifier) -> String {
        let code = currencyCode ?? "EUR"
        return budget.formatted(.currency(code: code))
    }
}
