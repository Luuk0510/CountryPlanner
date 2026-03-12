import SwiftUI

struct HomeView: View {
    
    // UI text constants
    private enum Strings {
        static let title = "Country Planner"
        static let subtitle = "Browse countries and make your planning."
        static let viewAll = "View all countries"
        static let selected = "Selected countries"
    }
    
    // Asset names used in the view
    private enum Assets {
        static let backgroundImage = "World"
    }
    
    // Layout values used in the screen
    private struct Layout {
        static let verticalSpacing: CGFloat = 16
        static let headerSpacing: CGFloat = 16
        static let buttonSpacing: CGFloat = 12
        static let portraitImageHeight: CGFloat = 350
        
        static let backgroundOpacity: Double = 0.22
        static let backgroundBlur: CGFloat = 8
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    background(for: geo)
                    
                    VStack(spacing: Layout.verticalSpacing) {
                        Spacer()
                        // Header with title and subtitle
                        HomeHeaderView(
                            isLandscape: isLandscape(geo),
                            title: Strings.title,
                            subtitle: Strings.subtitle,
                            portraitImageHeight: Layout.portraitImageHeight,
                            spacing: Layout.headerSpacing
                        )
                        
                        Spacer()
                        // Navigation buttons
                        HomeButtonsView(
                            viewAllTitle: Strings.viewAll,
                            selectedTitle: Strings.selected,
                            spacing: Layout.buttonSpacing
                        )
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
    // Detects if the device is in landscape orientation
    private func isLandscape(_ geo: GeometryProxy) -> Bool {
        geo.size.width > geo.size.height
    }
    // Background image used in landscape mode
    private func background(for geo: GeometryProxy) -> some View {
        Group {
            if isLandscape(geo) {
                Image(Assets.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .opacity(Layout.backgroundOpacity)
                    .blur(radius: Layout.backgroundBlur)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    HomeView()
}
