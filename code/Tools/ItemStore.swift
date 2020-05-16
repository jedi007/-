//
//  ItemStore.swift
//  jediChat
//
//  Created by 李杰 on 2020/5/16.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        //UIImageJPEGRepresentation(image, 0.5) => UIImage.jpegData(compressionQuality:)
        if let data = image.jpegData(compressionQuality: 1){
            let _ = try?data.write(to: url, options: [.atomic])
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        //return cache.object(forKey: key as NSString)
        
        if let existingImage = cache.object(forKey: key as NSString){
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
            
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do{
            try FileManager.default.removeItem(at: url)
        } catch let deleteError{
            print(" Error removing the image from disk: \(deleteError)")
        }
    }
    
    //单例
    static let shareSingleOne = ImageStore()
    private init() {}
}
