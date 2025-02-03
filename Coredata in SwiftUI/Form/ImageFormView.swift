import SwiftUI
import PhotosUI
struct ImageFormView: View {
    
    @ObservedObject var viewModel: FormViewModel
    @StateObject var imagePicker =  ImagePicker()
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [])
    private var myImages: FetchedResults<MyImage>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: viewModel.uiImage)
                    .resizable()
                    .scaledToFit()
                
                TextField("Image Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    if viewModel.updating {
                        PhotosPicker("Change Image",
                                     selection: $imagePicker.imageSelection,
                                     matching: .images,
                                     photoLibrary: .shared())
                        .buttonStyle(.bordered)
                    }
                    
                    Button {
                        if viewModel.updating {
                            if let id = viewModel.id, let selectedImage = myImages.first(where: { $0.id == id }) {
                                selectedImage.name = viewModel.name
                                FileManager().saveImage(with: id, image: viewModel.uiImage)
                                if moc.hasChanges {
                                    try? moc.save()
                                }
                            }
                        } else {
                            let newImage = MyImage(context: moc)
                            newImage.name = viewModel.name
                            newImage.id = UUID().uuidString
                            try? moc.save()
                            FileManager().saveImage(with: newImage.imageID, image: viewModel.uiImage)
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .disabled(viewModel.incomplete)
                }
                Spacer()
            }
            .padding()
            .navigationTitle(viewModel.updating ? "Update Image" : "New Image")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
                if viewModel.updating {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            if let selectedImage = myImages.first(where: { $0.id == viewModel.id}) {
                                FileManager().deleteImage(with: selectedImage.imageID)
                                moc.delete(selectedImage)
                                
                                try? moc.save()
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
            }
            .onChange(of: imagePicker.uiImage) { _, newImage in
                if let newImage {
                    viewModel.uiImage = newImage
                }
            }
            
        }
       
    }
}

#Preview {
    ImageFormView(viewModel: FormViewModel(uiImage: UIImage(systemName: "photo")!))
}
