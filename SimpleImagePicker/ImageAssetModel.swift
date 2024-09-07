//
//  ImageAssetModel.swift
//  SimpleImagePicker
//
//  Created by bebe on 9/6/24.
//

import Foundation
import PhotosUI
import SwiftUI

@Observable class ImageAssetModel {
    
    @ObservationIgnored
    private let imageManager = PHCachingImageManager()
    @ObservationIgnored
    private var pHAsset: PHFetchResult<PHAsset>?
    
    var images: [ImageAsset] = []
    var selected: ImageAsset? = nil
    
    @ObservationIgnored
    private lazy var requestOptions: PHImageRequestOptions = {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        return options
    }()
    
    init() {
        Task {
            let isAuthorized = await checkAuthorization()
            if (!isAuthorized) {
                return
            }
            fetchImages()
        }
    }
    
    private func checkAuthorization() async -> Bool {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized:
            print("Photo library access authorized.")
            return true
        case .notDetermined:
            print("Photo library access not determined.")
            return await PHPhotoLibrary.requestAuthorization(for: .readWrite) == .authorized
        case .denied:
            print("Photo library access denied.")
            return false
        case .limited:
            print("Photo library access limited.")
            return false
        case .restricted:
            print("Photo library access restricted.")
            return false
        @unknown default:
            return false
        }
    }
    
    func fetchImages() {
        let options = PHFetchOptions()
        options.includeHiddenAssets = false
        options.includeAssetSourceTypes = [.typeUserLibrary]
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        pHAsset = PHAsset.fetchAssets(with: .image, options: options)
        pHAsset?.enumerateObjects { asset,_,_ in
            self.loadImage(for: asset)
        }
    }

    func loadImage(for asset: PHAsset) {
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: requestOptions) {
            result, _ in
            if let image = result {
                self.images.append(ImageAsset(asset: asset, image: Image(uiImage: image)))
            }
        }
    }
    
    func loadLargeImage(for asset: PHAsset) {
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFill, options: requestOptions) {
            result, _ in
            if let image = result {
                self.selected = ImageAsset(asset: asset, image: Image(uiImage: image))
            }
        }
    }
}
