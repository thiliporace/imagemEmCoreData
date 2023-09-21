//
//  ImageFormView.swift
//  imagemEmCoreDataPOC
//
//  Created by Thiago Liporace on 21/09/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImageFormView: View {
    
    @FetchRequest(sortDescriptors: []) var images: FetchedResults<MyImage>
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var viewModel: FormViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var imagePicker = ImagePicker()
    
    var body: some View {
        NavigationStack{
            VStack{
                Image(uiImage: viewModel.uiImage)
                    .resizable()
                    .scaledToFit()
                TextField("Digite o nome da sua imagem", text: $viewModel.name)
            }
            HStack{
                if viewModel.updating {
                    PhotosPicker("Mudar a imagem", selection: $imagePicker.imageSelection,matching: .images,photoLibrary: .shared())
                        .buttonStyle(.bordered)
                }
                    
                    Button {
                        if viewModel.updating {
                            if let id = viewModel.id,
                               let selectedImage = images.first(where: {$0.id == id}) {
                                selectedImage.name = viewModel.name
                                FileManager().saveImage(with: id, image: viewModel.uiImage)
                                if context.hasChanges {
                                    try? context.save()
                                }
                            }
                        } else {
                            let newImage = MyImage(context: context)
                            newImage.name = viewModel.name
                            newImage.id = UUID().uuidString
                            try? context.save()
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
                .navigationTitle(viewModel.updating ? "Atualizar imagem" : "Nova imagem")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancelar") {
                            dismiss()
                        }
                        .buttonStyle(.bordered)
                    }
                    if viewModel.updating {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                if let selectedImage = images.first(where: {$0.id == viewModel.id}) {
                                    FileManager().deleteImage(with: selectedImage.imageID)
                                    context.delete(selectedImage)
                                    try? context.save()
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
        .padding()
        }
        .onChange(of: imagePicker.uiImage) { newImage in
            if let newImage {
                viewModel.uiImage = newImage
            }
        }
    }
}

#Preview {
    ImageFormView(viewModel: FormViewModel(uiImage: UIImage(systemName: "photo")!))
}
