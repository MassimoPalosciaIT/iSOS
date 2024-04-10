//
//
//
//
//
//

import SwiftUI
import Foundation

struct EmergencyMenu {
    var title: String
    var iconName: String
    var action: () -> Void

    init(title: String, iconName: String, action: @escaping () -> Void) {
        self.title = title
        self.iconName = iconName
        self.action = action
    }
}
