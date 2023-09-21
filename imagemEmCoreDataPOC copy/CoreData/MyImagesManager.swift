//
//  MyImagesContainer.swift
//  imagemEmCoreDataPOC
//
//  Created by Thiago Liporace on 20/09/23.
//

import Foundation
import CoreData

class MyImagesManager: ObservableObject {
    let container = NSPersistentContainer(name: "MyImagesDataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error in: \(error.localizedDescription)")
            }
        }
    }
}
