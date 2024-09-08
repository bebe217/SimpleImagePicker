//
//  SimpleImagePickerApp.swift
//  SimpleImagePicker
//
//  Created by bebe on 9/4/24.
//

import SwiftUI

@main
struct SimpleImagePickerApp: App {
    @State private var model = ImageAssetModel()
    
    @State private var gridColumn = 3

    var body: some Scene {
        WindowGroup {
            VStack {
                TopView(gridColumn: $gridColumn)
                ImageView(asset: model.selected)
                GridView(gridColumn: $gridColumn)
                    .environment(model)
            }
        }
    }
}

struct TopView: View {
    @Binding var gridColumn: Int
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    if (gridColumn < 5) {
                        gridColumn = gridColumn + 1
                    }
                }
            } label: {
                Image(systemName: "plus")
            }
            .frame(width: 40, height: 40)
        }
        .background(.yellow)
    }
}

struct ImageView: View {
    var asset: ImageAsset?
    
    var body: some View {
        ZStack {
            Image(systemName: "text.below.photo")
                .font(.system(size: 150))
                .opacity(0.2)
            if let asset = asset {
                asset.image
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 350)
        .padding(10)
    }
}
