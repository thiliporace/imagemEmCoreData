//
//  MyImage+Extension.swift
//  imagemEmCoreDataPOC
//
//  Created by Thiago Liporace on 20/09/23.
//

import Foundation
import UIKit

extension MyImage {
    var nameView: String {
        name ?? ""
    }
    
    var imageID: String {
        id ?? ""
    }
    
    var uiImage: UIImage {
        if !imageID.isEmpty,
           let image = FileManager().retrieveImage(with: imageID){
            return image
        }
        else {
            return UIImage(systemName: "photo")!
        }
    }
}
