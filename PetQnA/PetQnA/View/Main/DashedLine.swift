//
//  DashedLine.swift
//  PetQnA
//
//  Created by 조수민 on 7/21/24.
//

import SwiftUI

struct DashedLine: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
            .foregroundColor(.gray)
        }
        .frame(height: 1)
    }
}

#Preview {
    DashedLine()
}
