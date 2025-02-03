//
//  Coredata_in_SwiftUIApp.swift
//  Coredata in SwiftUI
//
//  Created by Ahmet Bostancıklıoğlu on 2.02.2025.
//

import SwiftUI

@main
struct AppEntry: App {
    var body: some Scene {
        WindowGroup {
            //SwiftUI bileşenlerine Core Data'nın managed object context'ini sağlamaya yarar
            MyImagesGridView()
                .environment(\.managedObjectContext, MyImagesContainer().persistentContainer.viewContext)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
            
        }
    }
}
