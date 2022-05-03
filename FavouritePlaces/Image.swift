//
//  Image.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 3/5/2022.
//

import Foundation
import SwiftUI

extension Image {
func data(url:URL) -> Self {
    if let data = try? Data(contentsOf: url) {
        return Image(uiImage: UIImage(data: data)!)
            .resizable()
    }
    return self
        .resizable()
    }
}
