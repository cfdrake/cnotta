//
//  Color+Cnotta.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI

extension Color {
    
    // MARK: - Project Colors
    
    static var projectColors: [Color] {
        return [
            Color.fromHexCode(0xf5969b),
            Color.fromHexCode(0xf49cc3),
            Color.fromHexCode(0xb08bc0),
            Color.fromHexCode(0x7da7d9),
            Color.fromHexCode(0x72c593),
            Color.fromHexCode(0xa4d390)
        ]
    }
    
    // MARK: - Hex Code Conversion
    
    static func fromHexCode(_ hex: Int) -> Color {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        return Color(red: red, green: green, blue: blue)
    }
    
    func toHexCode() -> Int {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        let color = UIColor(self)

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (Int(red * 255) << 16) | (Int(green * 255) << 8) | Int(blue * 255)
    }
    
}
