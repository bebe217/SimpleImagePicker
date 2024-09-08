//
//  GridView.swift
//  SimpleImagePicker
//
//  Created by bebe on 9/8/24.
//

import SwiftUI

struct GridView: View {
    @Environment(ImageAssetModel.self) var model: ImageAssetModel

    @Binding var gridColumn: Int
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridColumn)) {
                ForEach(model.images) { item in
                    GeometryReader { geo in
                        ZStack(alignment: .topTrailing) {
                            item.image
                                .resizable()
                                .scaledToFill()
                        }
                        .onTapGesture {
                            if (model.selected?.id == item.id) {
                                model.selected = nil
                            } else {
                                model.loadLargeImage(for: item.phAsset)
                            }
                        }
                    }
                    .cornerRadius(3.0)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(alignment: .center) {
                        if (model.selected?.id == item.id) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
