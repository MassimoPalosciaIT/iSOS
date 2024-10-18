//
//  AppIconExtension.swift
//  Yaha
//
//  Created by Matt Novoselov on 18/10/24.
//

import SwiftUI

// Extension to extract app icon from assets
extension Bundle {
    var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primary = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let files = primary["CFBundleIconFiles"] as? [String],
           let icon = files.last
        {
            return UIImage(named: icon)
        }
        
        return nil
    }
}
