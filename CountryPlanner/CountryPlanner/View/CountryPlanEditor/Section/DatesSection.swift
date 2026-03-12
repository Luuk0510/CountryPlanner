import SwiftUI

struct DatesSection: View {
    @ObservedObject var viewModel: CountryPlanEditorViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            DatePicker(
                CountryPlanEditorStrings.start,
                selection: $viewModel.startDate,
                displayedComponents: .date
            )
            .onChange(of: viewModel.startDate) { _, newStart in
                viewModel.startDateChanged(to: newStart)
            }

            Divider()

            DatePicker(
                CountryPlanEditorStrings.end,
                selection: $viewModel.endDate,
                in: viewModel.startDate...,
                displayedComponents: .date
            )
        }
    }
}
