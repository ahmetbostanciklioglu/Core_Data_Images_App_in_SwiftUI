import SwiftUI
import PhotosUI


struct MyImagesGridView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var myImages: FetchedResults<MyImage>
    @StateObject var imagePicker = ImagePicker()
    
    @State private var formType: FormType?
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    
    var body: some View {
        NavigationStack {
            Group {
                if !myImages.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(myImages) { myImage in
                                ImageButtonView(myImage: myImage) {
                                    formType = .update(myImage)
                                }
                            }
                        }
                    }
                } else {
                    Text("Select your first image")
                }
            }
            .navigationTitle("My Images")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker("New Image",
                                 selection: $imagePicker.imageSelection, matching: .images,
                                 photoLibrary: .shared())
                    .buttonStyle(.borderedProminent)
                }
            }
            .onChange(of: imagePicker.uiImage) { _, newImage in
                handleImageChange(newImage)
            }
            .sheet(item: $formType) { $0}
        }
    }
    
    func handleImageChange(_ newImage: UIImage?) {
        if let newImage {
            formType = .new(newImage)
        }
    }
}

#Preview {
    MyImagesGridView()
}


struct ImageButtonView: View {
    let myImage: MyImage
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(uiImage: myImage.uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .shadow(radius: 5.0)
                
                Text(myImage.nameView)
            }
        }
    }
}
