//
//  ImagePicker.swift
//  Coredata in SwiftUI
//
//  Created by Ahmet Bostancıklıoğlu on 3.02.2025.
//

import SwiftUI
import PhotosUI


//MARK: Buradaki kodun görevi Main thread'te PhotoPicker uygulamasını açabilmek, ve oradan resim seçebilmek


//MARK: - ImagePicker içerisinde @MainActor kullanılmasının sebebi resim seçme işleminin ana(main) thread üzerinde olması için
@MainActor
class ImagePicker: ObservableObject {
    @Published var imageSelection: PhotosPickerItem? {
        //didSet, bir property observer (özellik gözlemcisi) olup, değişkenin değeri her değiştiğinde çalıştırılan bir kod bloğudur.
        didSet {
            Task {
                try await loadTransferable(from: imageSelection)
            }
        }
    }
    @Published var image: Image?
    @Published var uiImage: UIImage?
    
    // MARK: - Fotoğraf seçme bölümünden(PhotoPicker) resim seçme işlemi yapıldıktan sonra UIImage(UIKit image türünde) datası SwiftUI'ın image(Image) data türüne çeviriliyor ve nil olma durumlarından if let ile kurtuluyor.
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.uiImage = uiImage
                    self.image = Image(uiImage: uiImage)
               
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
