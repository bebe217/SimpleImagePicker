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

    var body: some Scene {
        WindowGroup {
            VStack {
                TopView()
                ImageView(asset: model.selected)
                GridView()
                    .environment(model)
            }
        }
    }
}

struct TopView: View {
    var body: some View {
        HStack {
            Spacer()
            Button {
                //TODO: change grid count
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
