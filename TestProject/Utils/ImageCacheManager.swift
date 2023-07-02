//
//  ImageCacheManager.swift
//  TestProject
//
//  Created by Ritik Sharma on 21/03/23.
//

import Foundation
import UIKit

class ImageCacheManager{
    static let shared = ImageCacheManager()
    
    
    private init(){
        
    }
    
    func loadImageFrom(url: URL,success:@escaping (UIImage?) -> (),failure:@escaping () -> ()){
        
        self.getImageFromCache(url: url, success: {
            image in
            success(image)
            return
        }, failure: {
            failure()
        })
        let req = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: req){
            data,response,error in
            if let data = data {
                if let img = UIImage(data: data){
                    UserDefaults.standard.set(data, forKey: url.lastPathComponent)
                    success(img)
                }
                else{
                    self.getImageFromCache(url: url, success: {
                        image in
                        success(image)
                    }, failure: {
                        failure()
                    })
                }
            }
            else if let error{
                print(error)
                failure()
            }
        }
        task.resume()
    }
    
    private func getImageFromCache(url: URL,success:@escaping (UIImage?) -> (),failure:@escaping () -> ()){
        if let imgData = UserDefaults.standard.data(forKey: url.lastPathComponent){
            if let img = UIImage(data: imgData){
                success(img)
            }
            else{
                failure()
            }
        }
        else{
            failure()
        }
    }
}
