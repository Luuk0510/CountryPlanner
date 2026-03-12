import SwiftUI

struct CountryPlanEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var countryPlansVM: CountryPlansViewModel
    @Environment(\.verticalSizeClass) private var sizeClass

    @StateObject private var viewModel: CountryPlanEditorViewModel
    @State private var showDeleteConfirm = false

    init(plan: CountryPlan) {
        _viewModel = StateObject(wrappedValue: CountryPlanEditorViewModel(plan: plan))
    }

    var body: some View {
        VStack(spacing: 0) {
            if sizeClass == .compact {
                CountryPlanEditorLandscapeView(viewModel: viewModel)
            } else {
                CountryPlanEditorPortraitView(viewModel: viewModel)
            }

            CountryPlanEditorBottomBar(
                canSave: viewModel.canSave,
                onDone: {
                    viewModel.save(into: countryPlansVM)
                    dismiss()
                }
            )
            .padding(.horizontal, CountryPlanEditorLayout.pagePadding)
            .padding(.vertical, 12)
        }
        .navigationTitle(CountryPlanEditorStrings.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(.ultraThinMaterial)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showDeleteConfirm = true } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .alert(CountryPlanEditorStrings.deleteTitle, isPresented: $showDeleteConfirm) {
            Button(CountryPlanEditorStrings.deleteButton, role: .destructive) {
                countryPlansVM.delete(planId: viewModel.planId)
                dismiss()
            }
            Button(CountryPlanEditorStrings.cancelButton, role: .cancel) { }
        } message: {
            Text(CountryPlanEditorStrings.message)
        }
    }
}
