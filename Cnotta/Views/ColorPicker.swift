//
//  ColorPicker.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI

struct ColorPicker: View {
    
    @Binding var selectedColor: Color
    let colors: [Color]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.hashValue) { color in
                ZStack {
                    Circle()
                        .foregroundStyle(Color("ColorPickerBackground"))
                        .frame(width: 34, height: 34)
                        .opacity(color == selectedColor ? 1 : 0)
                    Rectangle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                        .cornerRadius(60)
                }
                .onTapGesture {
                    withAnimation {
                        selectedColor = color
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedColor = Color.projectColors.first!
    let colors = Color.projectColors
    
    ColorPicker(selectedColor: $selectedColor, colors: colors)
}
