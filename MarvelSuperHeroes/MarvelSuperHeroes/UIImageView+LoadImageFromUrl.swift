//
//  UIImage+LoadFromUrl.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 25/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(fromUrlString url:String, placeholder: UIImage) {
        self.image = placeholder
        ImageHttpClient.shared.getImage(urlString: url, callback: { image, error in
            if let image = image {
                self.image = image
            }
        })
    }
}
