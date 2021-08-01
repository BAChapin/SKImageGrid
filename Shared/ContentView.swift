//
//  ContentView.swift
//  Shared
//
//  Created by Brett Chapin on 7/30/21.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var viewModel = SKImageGridViewModel()
    
    var body: some View {
        HStack {
            if viewModel.image == nil{
            Rectangle()
                .foregroundColor(Color.red)
            } else {
                SpriteView(scene: viewModel.scene)
            }
            
            VStack {
                Spacer()
                
                Button("Add Image") {
                    viewModel.presentPicker = true
                }
                .padding()
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
                SteppableSlider(name: "Size", size: $viewModel.size, closedRange: 1.0...50.0)
                
                SteppableSlider(name: "X Offset", size: $viewModel.xOffset, closedRange: 0.0...25.0)
                
                SteppableSlider(name: "Y Offset", size: $viewModel.yOffset, closedRange: 0.0...25.0)
                
                Spacer()
            }
            .frame(width: 350)
            .border(Color.black, width: 1.0)
            .popover(isPresented: $viewModel.presentPicker) {
                ImagePicker(image: $viewModel.image)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
