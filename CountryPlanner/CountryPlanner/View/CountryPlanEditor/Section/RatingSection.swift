import SwiftUI

struct RatingSection: View {
    @ObservedObject var viewModel: CountryPlanEditorViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if viewModel.canRate {
                StarRatingView(rating: $viewModel.rating, max: 5, isEnabled: true)
            } else {
                Text(CountryPlanEditorStrings.ratingUnavailable)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
