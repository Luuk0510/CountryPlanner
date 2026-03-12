import SwiftUI

struct CountryDetailView: View {
    @EnvironmentObject private var countryPlansVM: CountryPlansViewModel
    @Environment(\.verticalSizeClass) private var sizeClass
    
    let country: Country
    
    @State private var showDeleteConfirm = false
    @State private var newPlanToEdit: CountryPlan?
    
    // UI text constants
    private enum Strings {
        static let editPlan = "Edit plan"
        static let deleteTitle = "Delete this plan?"
        static let deleteButton = "Delete"
        static let cancelButton = "Cancel"
        
        static func deleteMessage(countryName: String) -> String {
            "This will remove the trip plan for \(countryName)."
        }
    }
    
    // Layout values used in the screen
    private struct Layout {
        static let spacing: CGFloat = 12
        static let screenPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 20
        static let strokeOpacity: Double = 0.10
        static let flagAspectRatio: CGFloat = 3/2
    }
    
    // Retrieves the plan for the current country if it exists
    private var plan: CountryPlan? {
        countryPlansVM.plan(for: country.id)
    }
    
    var body: some View {
        ScrollView {
            contentLayout
                .padding(Layout.screenPadding)
        }
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { toolbarContent }
        
        // Delete confirmation dialog
        .alert(Strings.deleteTitle, isPresented: $showDeleteConfirm) {
            Button(Strings.deleteButton, role: .destructive) {
                deletePlanIfNeeded()
            }
            Button(Strings.cancelButton, role: .cancel) { }
        } message: {
            Text(Strings.deleteMessage(countryName: country.name))
        }
        .background(.ultraThinMaterial)
        	
        // Opens the editor when a new plan is created
        .navigationDestination(item: $newPlanToEdit) { plan in
            CountryPlanEditorView(plan: plan)
        }
    }
}

private extension CountryDetailView {
    
    // Chooses layout based on orientation
    @ViewBuilder
    var contentLayout: some View {
        if sizeClass == .compact {
            landscapeLayout
        } else {
            portraitLayout
        }
    }
    
    // Layout used in portrait orientation
    var portraitLayout: some View {
        VStack(alignment: .leading, spacing: Layout.spacing) {
            header
            
            if let plan {
                planContent(plan)
            } else {
                emptyState
            }
        }
    }
    
    //Countryflag header
    var landscapeLayout: some View {
        HStack(alignment: .top, spacing: Layout.spacing) {
            
            header
                .frame(maxWidth: 260)
            
            VStack(alignment: .leading, spacing: Layout.spacing) {
                if let plan {
                    planContent(plan)
                } else {
                    emptyState
                }
            }
            
            Spacer()
        }
    }
    
    // Layout used in landscape orientation
    var header: some View {
        CountryDetailHeaderView(
            flagUrl: country.flagUrl,
            cornerRadius: Layout.cornerRadius,
            strokeOpacity: Layout.strokeOpacity,
            aspectRatio: Layout.flagAspectRatio
        )
    }
    
    // Displays plan details and edit button
    func planContent(_ plan: CountryPlan) -> some View {
        VStack(alignment: .leading, spacing: Layout.spacing) {
            
            CountryDetailPlanCardView(
                plan: plan,
                cornerRadius: Layout.cornerRadius,
                strokeOpacity: Layout.strokeOpacity
            )
            
            CountryDetailNotesCardView(
                notes: plan.notes,
                cornerRadius: Layout.cornerRadius,
                strokeOpacity: Layout.strokeOpacity
            )
            
            NavigationLink {
                CountryPlanEditorView(plan: plan)
            } label: {
                Text(Strings.editPlan)
            }.buttonStyle(PrimaryButtonStyle())

        }
    }
    
    // Empty state when no plan exists for the country
    var emptyState: some View {
        CountryDetailEmptyStateView(
            countryName: country.name,
            cornerRadius: Layout.cornerRadius,
            strokeOpacity: Layout.strokeOpacity,
            onAddPlan: addPlan
        )
    }
    
    // Toolbar with delete action
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        if plan != nil {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showDeleteConfirm = true
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }
    
    // Creates a new plan and opens the editor
    func addPlan() {
        newPlanToEdit = countryPlansVM.makeDraftPlan(for: country)
    }
    
    // Deletes the current plan if it exists
    func deletePlanIfNeeded() {
        guard let plan else { return }
        countryPlansVM.delete(planId: plan.id)
    }
}
