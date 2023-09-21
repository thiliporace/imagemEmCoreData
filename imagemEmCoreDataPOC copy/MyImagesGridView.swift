//
//  ContentView.swift
//  imagemEmCoreDataPOC
//
//  Created by Thiago Liporace on 20/09/23.
//

import SwiftUI
import PhotosUI

struct MyImagesGridView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var images: FetchedResults<MyImage>
    @StateObject var imagePicker = ImagePicker()
    @State var formType: FormType?
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    var body: some View {
        NavigationStack{
            Group{
                if !images.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(images) {myImage in
                                Button {
                                    formType = .update(myImage)
                                } label: {
                                    VStack {
                                        Image(uiImage: myImage.uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                            .shadow(radius: 5)
                                        Text(myImage.nameView)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                else{
                    Text("")
                }
            }
            .navigationTitle("My Images")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker("New Image", selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared())
                        .buttonStyle(.borderedProminent)
                }
            }
            .onChange(of: imagePicker.uiImage) { newImage in
                if let newImage {
                    formType = .new(newImage)
                }
            }
            .sheet(item: $formType) { $0
            }
        }
    }
}


