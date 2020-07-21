import SwiftUI

struct CurrentUser: EnvironmentKey {
    static var defaultValue: String = ""
}

extension EnvironmentValues {
    var currentUser: String {
        get { self[CurrentUser.self] }
        set { self[CurrentUser.self] = newValue }
    }
}
