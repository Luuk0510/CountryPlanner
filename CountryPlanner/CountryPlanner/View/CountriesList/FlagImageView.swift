import SwiftUI

struct FlagImageView: View {
    
    let urlString: String
    let aspectRatio: CGFloat
    let cornerRadius: CGFloat
    

    private enum Layout {
        static let placeholderOpacity: Double = 0.2
    }
    

    private enum Icons {
        static let fallback = "flag"
    }
    

    private var imageUrl: URL? {
        URL(string: urlString)
    }
    
    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
                
            case .empty:
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.gray.opacity(Layout.placeholderOpacity))
                    
                    ProgressView()
                }
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(aspectRatio, contentMode: .fit)
                    .clipShape(
                        RoundedRectangle(cornerRadius: cornerRadius)
                    )
                
            case .failure:
                Image(systemName: Icons.fallback)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(aspectRatio, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
            @unknown default:
                EmptyView()
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .clipShape(
            RoundedRectangle(cornerRadius: cornerRadius)
        )
    }
}
