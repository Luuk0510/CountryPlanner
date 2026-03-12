import SwiftUI

struct CountryDetailHeaderView: View {
    
    let flagUrl: String?
    let cornerRadius: CGFloat
    let strokeOpacity: Double
    let aspectRatio: CGFloat
    
    private var imageUrl: URL? {
        guard let flagUrl, !flagUrl.isEmpty
        else {
            return nil
        }
        
        return URL(string: flagUrl)
    }
    
    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
                
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity)
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                
            case .failure:
                Image(systemName: "flag")
                    .frame(maxWidth: .infinity)
                
            @unknown default:
                EmptyView()
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .frame(maxWidth: .infinity)
        .clipShape(
            RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous
            )
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous
            )
            .stroke(.primary.opacity(strokeOpacity), lineWidth: 1)
        )
    }
}
