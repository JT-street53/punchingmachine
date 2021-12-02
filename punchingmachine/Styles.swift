//
//  Styles.swift
//  punchingmachine
//
//  Created by Shelshoker on 2021/12/01.
//

import SwiftUI

//
//  Custom Button
//
struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
        configuration.label.foregroundColor(Color(hex: 0xFDFFF7))
      Spacer()
    }
    .padding(18)
    .background(Color(hex: 0x59FFA0).cornerRadius(20))
    .scaleEffect(configuration.isPressed ? 0.9 : 0.77)
  }
}

//
//  Custom Color : Able to use HTML Color Code
//
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
