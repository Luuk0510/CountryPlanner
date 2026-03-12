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
    
    func delete(planId: UUID) {
        plans.removeAll { $0.id == planId }
        persist()
    }
    
    var upcomingPlans: [CountryPlan] {
        // Keep trips visible as upcoming until they have fully ended.
        let todayStart = Calendar.current.startOfDay(for: Date())
        return plans
            .filter { $0.endDate >= todayStart }
            .sorted { $0.startDate < $1.startDate }
    }
    
    var pastPlans: [CountryPlan] {
        // A trip is only past once its end date is before today.
        let todayStart = Calendar.current.startOfDay(for: Date())
        return plans
            .filter { $0.endDate < todayStart }
            .sorted { $0.startDate > $1.startDate }
    }
    
    private func persist() {
        store.save(plans)
    }
}
