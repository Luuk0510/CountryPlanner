import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color.accentColor)
            )
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .opacity(configuration.isPressed ? 0.9 : 1)
    }
}
