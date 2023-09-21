//
//  FormType.swift
//  imagemEmCoreDataPOC
//
//  Created by Thiago Liporace on 21/09/23.
//

import Foundation
import SwiftUI

enum FormType: Identifiable, View {
    case new(UIImage)
    case update(MyImage)
    
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new(let uiImage):
            return ImageFormView(viewModel: FormViewModel(uiImage: uiImage))
        case .update(let myImage):
            return ImageFormView(viewModel: FormViewModel(myImage))
        }
    }
}
