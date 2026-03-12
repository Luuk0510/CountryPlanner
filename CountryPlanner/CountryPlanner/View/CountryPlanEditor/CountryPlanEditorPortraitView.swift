import SwiftUI

struct CountryPlanEditorPortraitView: View {
    @ObservedObject var viewModel: CountryPlanEditorViewModel

    var body: some View {
        Form {
            Section(CountryPlanEditorStrings.dates) { DatesSection(viewModel: viewModel) }
            Section(CountryPlanEditorStrings.details) { DetailsSection(viewModel: viewModel) }
            Section(CountryPlanEditorStrings.rating) { RatingSection(viewModel: viewModel) }
            Section(CountryPlanEditorStrings.notes) { NotesSection(viewModel: viewModel) }
        }
        .scrollContentBackground(.hidden)
    }
}
