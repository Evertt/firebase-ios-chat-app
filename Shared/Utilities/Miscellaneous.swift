import SwiftUI
import Foundation

func delay(_ seconds: Double, _ fn: @escaping () -> ()) {
    delayed(seconds, fn)()
}

func delayed(_ seconds: Double, _ fn: @escaping () -> ()) -> () -> () {
    return {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            fn()
        }
    }
}

func track(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
    print("\n\(message)\nCalled from \(function) \(file):\(line)\n")
}

extension Double {
    var seconds: Double { self }
}

struct AnimationDuration: EnvironmentKey {
    static var defaultValue: Double = 0.5
}

extension EnvironmentValues {
    var animationDuration: Double {
        get { self[AnimationDuration.self] }
        set { self[AnimationDuration.self] = newValue }
    }
}

extension View {
    public func flip(_ flip: Bool = true) -> some View {
        return self
            .rotationEffect(.radians(flip ? .pi : 0))
            .scaleEffect(x: flip ? -1 : 1, y: 1, anchor: .center)
    }
    
    #if os(iOS) || os(watchOS)
    public func onExitCommand(perform action: (() -> Void)?) -> some View {
        return self
    }
    #endif
}
