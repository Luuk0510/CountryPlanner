import SwiftUI

struct HomeButtonsView: View {
    @Environment(\.verticalSizeClass) private var sizeClass
    
    let viewAllTitle: String
    let selectedTitle: String
    let spacing: CGFloat
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                landscapeLayout
            } else {
                portraitLayout
            }
        }
    }
}

private extension HomeButtonsView {
    var portraitLayout: some View {
        VStack(spacing: spacing) {
            viewAllButton
            selectedButton
        }
    }
    
    var landscapeLayout: some View {
        HStack(spacing: spacing) {
            viewAllButton
            selectedButton
        }
    }
    
    var viewAllButton: some View {
        NavigationLink { CountriesListView() } label: {
            Text(viewAllTitle)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
    
    var selectedButton: some View {
        NavigationLink { SelectedCountriesView() } label: {
            Text(selectedTitle)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}
