import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    var scaleAmount: CGFloat = 0.95
    var animation: Animation = .spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .animation(animation, value: configuration.isPressed)
            .brightness(configuration.isPressed ? 0.1 : 0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

extension View {
    func pressableButtonStyle() -> some View {
        self.buttonStyle(PressableButtonStyle())
    }
}
