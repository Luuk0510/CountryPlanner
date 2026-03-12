import SwiftUI

struct CountryRowView: View {
    
    let country: Country
    let isFavorite: Bool
    let onToggleFavorite: () -> Void
    
    private enum Layout {
        static let rowPadding: CGFloat = 12
        static let rowCornerRadius: CGFloat = 14
        static let flagHeight: CGFloat = 28
        static let imageAspectRatio: CGFloat = 3/2
        static let imageCornerRadius: CGFloat = 6
        static let spacing: CGFloat = 12
        static let iconSpacing: CGFloat = 8
    }

    private enum Icons {
        static let favorite = "star"
        static let favoriteFilled = "star.fill"
        static let chevron = "chevron.right"
    }
    

    private var favoriteIcon: String {
        isFavorite ? Icons.favoriteFilled : Icons.favorite
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
            
            HStack(spacing: Layout.iconSpacing) {

                Button(action: onToggleFavorite) {
                    Image(systemName: favoriteIcon)
                        .foregroundStyle(.yellow)
                }
                .buttonStyle(.plain)
                
                Image(systemName: Icons.chevron)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(Layout.rowPadding)
        .background(Color.white)
        .cornerRadius(Layout.rowCornerRadius)
    }
}
