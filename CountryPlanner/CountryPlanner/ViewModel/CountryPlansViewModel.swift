import Foundation
import Combine

final class CountryPlansViewModel: ObservableObject {
    @Published private(set) var plans: [CountryPlan] = []
    
    private let store: CountryPlansStore
    
    init(store: CountryPlansStore = CountryPlansStore()) {
        self.store = store
        self.plans = store.load()
    }
    
    func plan(for countryId: String) -> CountryPlan? {
        plans.first { $0.countryId == countryId }
    }
    
    func makeDraftPlan(for country: Country) -> CountryPlan {
        CountryPlan(
            countryId: country.id,
            countryName: country.name,
            imageName: country.flagUrl
        )
    }
    
    func savePlan(_ plan: CountryPlan) {
        if let index = plans.firstIndex(where: { $0.id == plan.id }) {
            plans[index] = plan
        } else {
            plans.append(plan)
        }
        persist()
    }
    
    func updatePlan(
        planId: UUID,
        startDate: Date,
        endDate: Date,
        budget: Double,
        peopleCount: Int,
        notes: String,
        rating: Int?
    ) {
        guard let index = plans.firstIndex(where: { $0.id == planId }) else { return }
        
        plans[index].startDate = startDate
        plans[index].endDate = endDate
        plans[index].budget = budget
        plans[index].peopleCount = peopleCount
        plans[index].notes = notes
        plans[index].rating = rating
        
        persist()
    }
    
    func updateRating(planId: UUID, rating: Int?) {
        guard let index = plans.firstIndex(where: { $0.id == planId }) else { return }
        plans[index].rating = rating
        persist()
    }
    
    func delete(planId: UUID) {
        plans.removeAll { $0.id == planId }
        persist()
    }
    
    var upcomingPlans: [CountryPlan] {
        // Use start-of-day boundaries so plans starting later today are still "upcoming."
        let todayStart = Calendar.current.startOfDay(for: Date())
        return plans
            .filter { $0.startDate >= todayStart }
            .sorted { $0.startDate < $1.startDate }
    }
    
    var pastPlans: [CountryPlan] {
        // Keep past plans in reverse chronological order to show most recent trips first.
        let todayStart = Calendar.current.startOfDay(for: Date())
        return plans
            .filter { $0.startDate < todayStart }
            .sorted { $0.startDate > $1.startDate }
    }
    
    private func persist() {
        store.save(plans)
    }
}
