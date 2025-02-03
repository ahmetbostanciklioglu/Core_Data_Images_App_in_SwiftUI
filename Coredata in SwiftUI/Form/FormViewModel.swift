import UIKit


class FormViewModel: ObservableObject {
    
    //1 - Formda kullanılacak resmini adını ve seçilecek objenin türünü(UIImage), id, resim daha önce var(id ile kontrol ediyor) veriyor
    @Published var name = ""
    @Published var uiImage: UIImage
    
    var id: String?
    
    var updating: Bool {
        id != nil
    }
    
    //MARK:  Yeni bir resim oluşturuyor isek bu init çalışacaktır ve UIImage türünde veri alınıyor(UIImage, UIKit'te bulunuyor).
    init( uiImage: UIImage) {
        self.uiImage = uiImage
    }
    
    //MARK:  Var olan resmime yönlendiriyorum ve MyImage türünde veri alınıyor(Image, SwiftUI'da bulunuyor)
    init(_ myImage: MyImage) {
        name = myImage.nameView
        id = myImage.imageID
        
        uiImage = myImage.uiImage
    }
    
    //MARK: - Bu formda resim oluşturma işlemi yapılmadı ise yani resmini ismi boş ve seçilen bir resim(systemName hala photo ise) yok ise form tamamlanmadı diyecektir
    var incomplete: Bool {
        name.isEmpty || uiImage == UIImage(systemName: "photo")!
    }
    
}
