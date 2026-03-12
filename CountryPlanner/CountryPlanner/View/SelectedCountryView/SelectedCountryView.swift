import SwiftUI

struct SelectedCountriesView: View {
    
    @EnvironmentObject private var countryPlansVM: CountryPlansViewModel
    
    // UI text constants
    private enum Strings {
        static let title = "Selected countries"
        static let upcoming = "Upcoming"
        static let past = "Past"
        static let emptyTitle = "No selected countries"
        static let emptyDescription = "Create a plan from the countries list."
        static let emptyIcon = "globe.europe.africa"
    }
    
    // Layout values used in the view
    private enum Layout {
        static let rowSpacing: CGFloat = 12
        static let textSpacing: CGFloat = 4
        
        static let flagWidth: CGFloat = 44
        static let flagHeight: CGFloat = 28
        static let flagCornerRadius: CGFloat = 6
        static let flagAspectRatio: CGFloat = 3/2
        
        static let ratingScale: CGFloat = 0.75
    }
    
    var body: some View {
        List {
                
            // Empty state when no plans exist
            if countryPlansVM.plans.isEmpty {
                ContentUnavailableView(
                    Strings.emptyTitle,
                    systemImage: Strings.emptyIcon,
                    description: Text(Strings.emptyDescription)
                )
            } else {
                
                // Empty state when no plans exist
                if !countryPlansVM.upcomingPlans.isEmpty {
                    Section(Strings.upcoming) {
                        ForEach(countryPlansVM.upcomingPlans) { plan in
                            planRow(plan)
                        }
                        .onDelete { offsets in
                            delete(from: countryPlansVM.upcomingPlans, at: offsets)
                        }
                    }
                }
                
                // Past trip plans
                if !countryPlansVM.pastPlans.isEmpty {
                    Section(Strings.past) {
                        ForEach(countryPlansVM.pastPlans) { plan in
                            planRow(plan)
                        }
                        .onDelete { offsets in
                            delete(from: countryPlansVM.pastPlans, at: offsets)
                        }
                    }
                }
            }
        }
        .navigationTitle(Strings.title)
        // Enables edit mode for deleting plans
        .toolbar {
            if !countryPlansVM.plans.isEmpty {
                EditButton()
            }
        }
    }
    
    // Row showing a country plan with flag, dates, and optional rating
    @ViewBuilder
    private func planRow(_ plan: CountryPlan) -> some View {
        NavigationLink {
            CountryDetailView(country: country(from: plan))
        } label: {
            HStack(spacing: Layout.rowSpacing) {
                
                // Country flag
                FlagImageView(
                    urlString: plan.imageName,
                    aspectRatio: Layout.flagAspectRatio,
                    cornerRadius: Layout.flagCornerRadius
                )
                .frame(width: Layout.flagWidth, height: Layout.flagHeight)
                
                VStack(alignment: .leading, spacing: Layout.textSpacing) {
                    
                    Text(plan.countryName)
                        .font(.headline)
                    
                    Text(dateRangeText(for: plan))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    // Show rating only for completed trips
                    if plan.isTripOver, let rating = plan.rating {
                        StarRatingView(
                            rating: .constant(rating),
                            max: 5,
                            isEnabled: false
                        )
                        .scaleEffect(Layout.ratingScale)
                        .foregroundStyle(.yellow)
                    }
                }
            }
        }
    }
    
    // Formats the date range for display
    private func dateRangeText(for plan: CountryPlan) -> String {
        let start = plan.startDate.formatted(date: .abbreviated, time: .omitted)
        let end = plan.endDate.formatted(date: .abbreviated, time: .omitted)
        return "\(start) – \(end)"
    }
    
    // Deletes selected plans from the view model
    private func delete(from plans: [CountryPlan], at offsets: IndexSet) {
        for index in offsets {
            let id = plans[index].id
            countryPlansVM.delete(planId: id)
        }
    }
    
    // Converts a CountryPlan into a Country so it can be used in CountryDetailView
    private func country(from plan: CountryPlan) -> Country {
        Country(
            id: plan.countryId,
            name: plan.countryName,
            flagUrl: plan.imageName
        )
    }
}
