//
//  ICOSetup.swift
//  App_BlogWP
//
//  Created by User on 19/11/15.
//  Copyright © 2015 iCologic. All rights reserved.
//

import Foundation
import UIKit

public class ImageLoader{
    
    
    var cache = NSCache()// Alloc init

    class var sharedloader: ImageLoader {
        
        struct Static {
            static let instance: ImageLoader = ImageLoader()
        }
        
        return Static.instance
    }
    
    
    
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            
            let data: NSData? = self.cache.objectForKey(urlString) as? NSData
            
            if let goodData = data{
                
                let image = UIImage(data: goodData)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    completionHandler(image: image, url: urlString)
                    
                })
                return
            }
            
            let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!,
                completionHandler: {(data:NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                
                if (error != nil){
                    
                    completionHandler(image: nil, url: urlString)
                    return
                }
                
                if data != nil{
                    
                    let image = UIImage(data: data!)
                    self.cache.setObject(data!, forKey: urlString)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        completionHandler(image: image, url: urlString)
                        
                    })
                    return
                }
            })
            
            downloadTask.resume()
        }
    }
    
}
