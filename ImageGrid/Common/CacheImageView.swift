//
//  ImageGridCaches.swift
//  ImageGrid
//
//  Created by Manick on 16/04/24.
//

import Foundation
import UIKit

class CacheImageView : UIImageView{
    var task :  URLSessionDataTask!
    var imageCache = NSCache<AnyObject,AnyObject>()
    
    func loadimage(url : URL){
        image = nil
        if let task = task{
            task.cancel()
        }
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data, let newImage = UIImage(data: data) else{
//                print("couldn't load image from url: \(url)")
                return
            }
            self.imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async{
                self.image = newImage
            }
        }
        task.resume()
    }
}
