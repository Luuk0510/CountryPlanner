import SwiftUI

struct NotesSection: View {
    @ObservedObject var viewModel: CountryPlanEditorViewModel

    var body: some View {
        ZStack(alignment: .topLeading) {
            if viewModel.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(CountryPlanEditorStrings.notesPlaceholder)
                    .foregroundStyle(.secondary)
                    .padding(.top, CountryPlanEditorLayout.placeholderTopPadding)
                    .padding(.leading, CountryPlanEditorLayout.placeholderLeadingPadding)
            }

            TextEditor(text: $viewModel.notes)
                .frame(minHeight: CountryPlanEditorLayout.notesMinHeight)
        }
    }
}
