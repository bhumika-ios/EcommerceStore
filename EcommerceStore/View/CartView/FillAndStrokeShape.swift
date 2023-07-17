//
//  FillAndStrokeShape.swift
//  EcommerceStore
//
//  Created by Bhumika Patel on 11/07/23.
//

import SwiftUI

struct FillAndStrokeShape: View {
    var body: some View {
        strokeAndFilledCircle(strokeColor: Color.blue, lineWidth: 10, fillColor: Color.red)
    }

    func strokeAndFilledCircle(strokeColor: Color,lineWidth: CGFloat, fillColor: Color)-> some View{
        let circle = Circle()
        
        return
            ZStack{
                circle.fill(fillColor)
                circle.stroke(lineWidth: lineWidth)
                       .fill(strokeColor)
        }
    }
}

