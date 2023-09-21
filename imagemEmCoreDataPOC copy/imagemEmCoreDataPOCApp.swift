//
//  imagemEmCoreDataPOCApp.swift
//  imagemEmCoreDataPOC
//
//  Created by Thiago Liporace on 20/09/23.
//

import SwiftUI

@main
struct imagemEmCoreDataPOCApp: App {
    var body: some Scene {
        WindowGroup {
            MyImagesGridView()
                .environment(\.managedObjectContext, MyImagesManager().container.viewContext)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
        }
    }
}
