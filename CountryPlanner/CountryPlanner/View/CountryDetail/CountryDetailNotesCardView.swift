import SwiftUI

struct CountryDetailNotesCardView: View {
    
    let notes: String
    let cornerRadius: CGFloat
    let strokeOpacity: Double
    
    private enum Strings {
        static let title = "Notes"
        static let empty = "No notes yet."
    }
    
    private enum Layout {
        static let spacing: CGFloat = 10
    }
    
    private var hasNotes: Bool {
        !notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.spacing) {
            Text(Strings.title)
                .font(.headline)
            if hasNotes {
                Text(notes)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(Strings.empty)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .cardStyle(
            cornerRadius: cornerRadius,
            strokeOpacity: strokeOpacity
        )
    }
}
