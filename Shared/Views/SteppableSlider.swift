//
//  SteppableSlider.swift
//  SteppableSlider
//
//  Created by Brett Chapin on 8/1/21.
//

import SwiftUI

struct SteppableSlider: View {
    
    var name: String
    @Binding var size: CGFloat
    var closedRange: ClosedRange<CGFloat>
    
    var body: some View {
        VStack {
            Text(name)
            Slider(value: $size, in: closedRange)
            Stepper(String(format: "%.1f", size)) {
                if size < closedRange.upperBound {
                    size += 0.1
                }
            } onDecrement: {
                if size > closedRange.lowerBound {
                    size -= 0.1
                }
            }

        }
        .padding(.horizontal)
    }
    
}

struct SteppableSlider_Preview: PreviewProvider {
    static var previews: some View {
        SteppableSlider(name: "Test", size: .constant(10.0), closedRange: 1.0...50.0)
    }
}

