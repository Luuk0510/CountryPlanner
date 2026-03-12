import SwiftUI

private enum CardStyleLayout {
    static let padding: CGFloat = 14
    static let lineWidth: CGFloat = 1
}

extension View {
    func cardStyle(
        cornerRadius: CGFloat,
        strokeOpacity: Double
    ) -> some View {
        self
            .padding(CardStyleLayout.padding)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color(.systemBackground))
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(.primary.opacity(strokeOpacity), lineWidth: CardStyleLayout.lineWidth)
            }
    }
}
