//
//  RemoteImageView.swift
//  PopularMovie
//
//  Created by Preeti Priyam on 7/5/21.
//

import UIKit

class RemoteImageView: UIImageView {
    
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImage(fromUrl imageURL: URL, key : String) {
        
        if let cachedImage = self.imageCache.object(forKey: key as AnyObject) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        //Cache to save downloaded image
                        self?.imageCache.setObject(image, forKey: key as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
