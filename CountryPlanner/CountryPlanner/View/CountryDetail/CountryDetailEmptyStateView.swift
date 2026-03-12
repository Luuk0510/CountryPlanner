import SwiftUI

struct CountryDetailEmptyStateView: View {
    
    let countryName: String
    let cornerRadius: CGFloat
    let strokeOpacity: Double
    let onAddPlan: () -> Void
    
    private enum Strings {
        static let title = "No trip plan yet"
        static let description = "Add a plan with dates, budget, people, and notes."
        static let button = "Add plan"
    }
    
    private enum Layout {
        static let spacing: CGFloat = 10
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.spacing) {
            
            Text(Strings.title)
                .font(.headline)
            
            Text(Strings.description)
                .foregroundStyle(.secondary)
            
            Button(Strings.button) {
                onAddPlan()
            }.buttonStyle(PrimaryButtonStyle())
        }
        .cardStyle(
            cornerRadius: cornerRadius,
            strokeOpacity: strokeOpacity
        )
    }
}
