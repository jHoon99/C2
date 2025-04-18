//
//  Hex.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

// Color+Hex.swift
import SwiftUI

extension Color {
    /// "RRGGBB" 또는 "#RRGGBB" 형태의 문자열로 Color 생성
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.currentIndex = hexString.index(after: hexString.startIndex)
        }
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red   = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8)  / 255.0
        let blue  = Double(rgbValue & 0x0000FF)         / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}
