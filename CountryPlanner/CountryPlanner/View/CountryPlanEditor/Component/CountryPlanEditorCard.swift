import SwiftUI

struct CountryPlanEditorCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle(
            cornerRadius: CountryPlanEditorLayout.cardCornerRadius,
            strokeOpacity: CountryPlanEditorLayout.cardStrokeOpacity
        )
    }
}
