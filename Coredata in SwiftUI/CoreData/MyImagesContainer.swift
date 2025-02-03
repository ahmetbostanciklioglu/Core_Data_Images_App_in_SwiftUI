import Foundation
import CoreData

//MARK: - Verinin yapılandırıldığı br container -
class MyImagesContainer {
    let persistentContainer: NSPersistentContainer
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "MyImagesDataModel")
        persistentContainer.loadPersistentStores { _, error in
            
            if let error { // error değerini opsiyonel olmaktan çıkardık
                print(error.localizedDescription)
            }
        }
    }
}
