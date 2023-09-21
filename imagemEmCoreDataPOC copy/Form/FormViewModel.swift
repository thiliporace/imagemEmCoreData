//
//  FormViewModel.swift
//  imagemEmCoreDataPOC
//
//  Created by Thiago Liporace on 20/09/23.
//

import Foundation
import UIKit

class FormViewModel: ObservableObject {
    @Published var name = ""
    @Published var uiImage: UIImage
    
    var id: String?
    
    var updating: Bool { id != nil }
    
    init(uiImage: UIImage) {
        self.uiImage = uiImage
    }
    
    init(_ myImage: MyImage) {
        name = myImage.nameView
        id = myImage.imageID
        uiImage = myImage.uiImage
    }
    
    var incomplete: Bool {
        name.isEmpty || uiImage == UIImage(systemName: "photo")
    }
}
