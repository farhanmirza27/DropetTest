//
//  ImageConverter.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 08/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class ImageConverter {
    // endcoding to base64
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? ""
    }
    // decoding from base64
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        if let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0)) {
            return UIImage(data: imageData)!
        }
        else {
            return UIImage(named: "default")!
        }
    }
}
