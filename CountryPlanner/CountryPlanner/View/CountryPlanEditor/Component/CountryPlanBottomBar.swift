import SwiftUI

struct CountryPlanEditorBottomBar: View {
    let canSave: Bool
    let onDone: () -> Void

    var body: some View {
        Button(CountryPlanEditorStrings.done) {
            onDone()
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!canSave)
    }
}
