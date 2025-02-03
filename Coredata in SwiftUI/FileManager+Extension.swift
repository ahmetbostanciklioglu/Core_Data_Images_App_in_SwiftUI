import UIKit


extension FileManager {
    
    //MARK: Var ise UIImage'i bize veren fonksiyon, yok ise nil dönecektir.
    func retrieveImage(with id: String) -> UIImage? {
        
        //MARK: - id yardımı ile document dosyasından URL'leleri aldık.
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        
        //MARK:  Data(contentsOf: url) hata fırlatabileceği için do-catch blok içerisine aldık.
        do {
            //MARK: - URL'yi imageData içerisine yerleştiriyoruz ve daha sonra UIImage içerisine bu datayı yerleştiriyoruz.
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    func saveImage(with id: String, image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.6) {
            do {
                let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Could not save image")
        }
    }
    
    func deleteImage(with id: String) {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        
        if fileExists(atPath: url.path) {
            do {
                try removeItem(at: url)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Image does not exist")
        }
        
    }
}
