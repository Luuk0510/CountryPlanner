import SwiftUI

struct CountryDetailPlanCardView: View {
    
    let plan: CountryPlan
    let cornerRadius: CGFloat
    let strokeOpacity: Double
    
    private enum Strings {
        static let title = "Trip plan"
        static let start = "Start"
        static let end = "End"
        static let budget = "Budget"
        static let people = "People"
        static let rating = "Rating"
        static let ratingUnavailable = "Available after the trip"
    }
    
    private enum Layout {
        static let spacing: CGFloat = 10
        static let ratingTopPadding: CGFloat = 4
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.spacing) {
            
            Text(Strings.title)
                .font(.headline)
            
            detailRow(
                title: Strings.start,
                value: plan.startDate.formatted(date: .abbreviated, time: .omitted)
            )
            
            detailRow(
                title: Strings.end,
                value: plan.endDate.formatted(date: .abbreviated, time: .omitted)
            )
            
            detailRow(
                title: Strings.budget,
                value: plan.formattedBudget()
            )
            
            detailRow(
                title: Strings.people,
                value: "\(plan.peopleCount)"
            )
            
            ratingRow(
                isOver: plan.isTripOver,
                rating: plan.rating
            )
        }
        .cardStyle(
            cornerRadius: cornerRadius,
            strokeOpacity: strokeOpacity
        )
    }
}


private extension CountryDetailPlanCardView {
    func detailRow(title: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text(value)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
    }
    
    func ratingRow(isOver: Bool, rating: Int?) -> some View {
        HStack {
            Text(Strings.rating)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            if isOver {
                StarRatingView(
                    rating: .constant(rating),
                    max: 5,
                    isEnabled: false
                )
            } else {
                Text(Strings.ratingUnavailable)
                    .foregroundStyle(.secondary)
            }
        }
        .font(.subheadline)
        .padding(.top, Layout.ratingTopPadding)
    }
}
