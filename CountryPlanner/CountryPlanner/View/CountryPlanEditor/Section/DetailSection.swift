import SwiftUI

struct DetailsSection: View {
    @ObservedObject var viewModel: CountryPlanEditorViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField(
                CountryPlanEditorStrings.budget,
                value: $viewModel.budget,
                format: .currency(code: viewModel.currencyCode)
            )
            .keyboardType(.decimalPad)

            Divider()

            Stepper {
                HStack {
                    Text(CountryPlanEditorStrings.people)
                    Spacer()
                    Text("\(viewModel.peopleCount)")
                        .foregroundStyle(.secondary)
                }
            } onIncrement: {
                viewModel.incrementPeople()
            } onDecrement: {
                viewModel.decrementPeople()
            }
        }
    }
}
