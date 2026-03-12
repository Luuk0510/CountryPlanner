import Foundation
import Combine

@MainActor
final class CountryPlanEditorViewModel: ObservableObject {
    
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var budget: Double
    @Published var peopleCount: Int
    @Published var notes: String
    @Published var rating: Int?
    
    private let originalPlan: CountryPlan
    
    private enum Limits {
        static let minPeople = 1
        static let maxPeople = 20
    }
    
    init(plan: CountryPlan) {
        self.originalPlan = plan
        
        self.startDate = plan.startDate
        self.endDate = plan.endDate
        self.budget = plan.budget
        self.peopleCount = plan.peopleCount
        self.notes = plan.notes
        self.rating = plan.rating
        
        // Normalize persisted values in case old data violates current UI rules.
        normalizeDates()
        clampPeople()
        clearRatingIfNeeded()
    }
    
    var planId: UUID {
        originalPlan.id
    }
    
    var currencyCode: String {
        Locale.current.currency?.identifier ?? "EUR"
    }
    
    var canSave: Bool {
        endDate >= startDate
    }
    
    var canRate: Bool {
        // Compare by day to avoid same-day time offsets affecting eligibility.
        let today = Calendar.current.startOfDay(for: Date())
        let end = Calendar.current.startOfDay(for: endDate)
        return end < today
    }
    
    func startDateChanged(to newStart: Date) {
        startDate = newStart
        normalizeDates()
    }
    
    func incrementPeople() {
        peopleCount = min(peopleCount + 1, Limits.maxPeople)
    }
    
    func decrementPeople() {
        peopleCount = max(peopleCount - 1, Limits.minPeople)
    }
    
    func save(into plansVM: CountryPlansViewModel) {
        var updated = originalPlan
        updated.startDate = startDate
        updated.endDate = endDate
        updated.budget = budget
        updated.peopleCount = peopleCount
        updated.notes = notes
        // Prevent stale ratings from being saved while a trip is still ongoing or in the future
        updated.rating = canRate ? rating : nil

        plansVM.savePlan(updated)
    }
    
    // Also revalidates rating because shifting dates can make a trip "not over" again.
    private func normalizeDates() {
        if endDate < startDate {
            endDate = startDate
        }
        clearRatingIfNeeded()
    }
    
    private func clampPeople() {
        peopleCount = min(max(peopleCount, Limits.minPeople), Limits.maxPeople)
    }
    
    private func clearRatingIfNeeded() {
        // Ratings are only valid for completed trips.
        if !canRate {
            rating = nil
        }
    }
}
