import SwiftUI

struct CountryPlanEditorLandscapeView: View {
    @ObservedObject var viewModel: CountryPlanEditorViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CountryPlanEditorLayout.gridSpacing) {

                LazyVGrid(
                    columns: CountryPlanEditorLayout.gridColumns,
                    alignment: .leading,
                    spacing: CountryPlanEditorLayout.gridSpacing
                ) {
                    CountryPlanEditorCard(title: CountryPlanEditorStrings.dates) {
                        DatesSection(viewModel: viewModel)
                    }

                    CountryPlanEditorCard(title: CountryPlanEditorStrings.details) {
                        DetailsSection(viewModel: viewModel)
                    }
                }

                CountryPlanEditorCard(title: CountryPlanEditorStrings.rating) {
                    RatingSection(viewModel: viewModel)
                }

                CountryPlanEditorCard(title: CountryPlanEditorStrings.notes) {
                    NotesSection(viewModel: viewModel)
                        .frame(maxWidth: CountryPlanEditorLayout.notesMaxTextWidth, alignment: .leading)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding(CountryPlanEditorLayout.pagePadding)
        }
    }
}
