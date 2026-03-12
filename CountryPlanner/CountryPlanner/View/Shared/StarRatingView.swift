import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int?
    
    let max: Int
    let isEnabled: Bool
    
    private enum Layout {
        static let starSpacing: CGFloat = 6
        static let clearSpacing: CGFloat = 6
    }
    
    private enum Icons {
        static let star = "star"
        static let starFilled = "star.fill"
        static let clear = "xmark.circle.fill"
    }
    
    private enum Strings {
        static let clearAccessibilityLabel = "Clear rating"
    }
    
    init(rating: Binding<Int?>, max: Int = 5, isEnabled: Bool = true) {
        self._rating = rating
        self.max = max
        self.isEnabled = isEnabled
    }
    
    var body: some View {
        HStack(spacing: Layout.starSpacing) {
            
            ForEach(1...max, id: \.self) { value in
                Button {
                    setRating(value)
                } label: {
                    Image(systemName: starName(for: value))
                        .imageScale(.large)
                        .foregroundStyle(starColor(for: value))
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled)
            }
            
            if isEnabled, rating != nil {
                Button {
                    rating = nil
                } label: {
                    Image(systemName: Icons.clear)
                        .imageScale(.medium)
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
                .padding(.leading, Layout.clearSpacing)
                .accessibilityLabel(Strings.clearAccessibilityLabel)
            }
        }
        .accessibilityElement(children: .contain)
    }
    
    private func setRating(_ value: Int) {
        guard isEnabled else { return }
        rating = value
    }
    
    private func starName(for value: Int) -> String {
        value <= currentRating ? Icons.starFilled : Icons.star
    }
    
    private func starColor(for value: Int) -> Color {
        value <= currentRating ? .yellow : .secondary
    }
    
    private var currentRating: Int {
        rating ?? 0
    }
}
