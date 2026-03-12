import SwiftUI

struct HomeHeaderView: View {
    
    let isLandscape: Bool
    let title: String
    let subtitle: String
    let portraitImageHeight: CGFloat
    let spacing: CGFloat
    
    private enum Assets {
        static let image = "World"
    }
    
    var body: some View {
        VStack(spacing: spacing) {
            
            if !isLandscape {
                Image(Assets.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: portraitImageHeight)
                    .frame(maxWidth: .infinity)
                    .clipped()
            }
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(subtitle)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}
