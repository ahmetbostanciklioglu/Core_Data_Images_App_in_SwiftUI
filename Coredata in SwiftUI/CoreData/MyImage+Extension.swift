//
//  MyImage+Extension.swift
//  Coredata in SwiftUI
//
//  Created by Ahmet Bostancıklıoğlu on 3.02.2025.
//

import UIKit

//MARK: CoreData içerisinde bulunan MyImage Entity içerisindeki opsiyonel (String?) değeri nil ise "" atanacak, nil değil ise name ve id değerleri atanacak
extension MyImage {
    var nameView: String {
        name ?? ""
    }
    
    var imageID: String {
        id ?? ""
    }
    
    
    var uiImage: UIImage {
        if !imageID.isEmpty, let image = FileManager().retrieveImage(with: imageID) {
            return image
        } else {
            return UIImage(systemName: "photo")!
        }
    }
}
