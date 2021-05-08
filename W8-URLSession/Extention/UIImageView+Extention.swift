//
//  UIImageView+Extention.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 05/05/2021.
//

import UIKit

extension UIImageView {
    static var imageCache = NSCache<AnyObject, AnyObject>()
    func gotImageAndCache(urlString: String, completion: @escaping (UIImage) -> Void) {
        guard var image: UIImage = UIImage(named: "empty") else { return}
        if let imageFromCache = UIImageView.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            completion(image)
            return
        }
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data) else { return }
                    UIImageView.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    image = imageToCache
                    completion(image)
                }
            }
        }
    }
}
