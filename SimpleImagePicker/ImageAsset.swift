//
//  ImageAsset.swift
//  SimpleImagePicker
//
//  Created by bebe on 9/8/24.
//

import Foundation
import Photos
import SwiftUI

struct ImageAsset: Identifiable {
    let id: String
    let phAsset: PHAsset
    let image: Image

    init(asset: PHAsset, image: Image) {
        self.id = asset.localIdentifier
        phAsset = asset
        self.image = image
    }
}
