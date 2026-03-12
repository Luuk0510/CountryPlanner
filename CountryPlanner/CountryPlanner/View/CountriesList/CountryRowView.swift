import SwiftUI

struct CountryRowView: View {
    
    let country: Country
    
    private enum Layout {
        static let flagHeight: CGFloat = 28
        static let imageAspectRatio: CGFloat = 3/2
        static let imageCornerRadius: CGFloat = 6
        static let spacing: CGFloat = 12
    }

    private enum Icons {
        static let chevron = "chevron.right"
    }
    
    var body: some View {
        HStack(spacing: Layout.spacing) {
            FlagImageView(
                urlString: country.flagUrl,
                aspectRatio: Layout.imageAspectRatio,
                cornerRadius: Layout.imageCornerRadius
            )
            .frame(height: Layout.flagHeight)
            
            Text(country.name)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: Icons.chevron)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}
