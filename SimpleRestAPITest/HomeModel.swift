//
//  HomeModel.swift
//  SimpleRestAPITest
//
//  Created by Rajesh on 7/4/18.
//  Copyright © 2018 Rajesh. All rights reserved.
//

import UIKit
import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, URLSessionDelegate {
    
    
    weak var delegate: HomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://localhost:8888/locations.php"
    
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
        
    
        

        func parseJSON(_ data:Data) {
            
            var jsonResult = NSArray()
            
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                
            } catch let error as NSError {
                print(error)
                
            }
            
            var jsonElement = NSDictionary()
            let locations = NSMutableArray()
            
            for i in 0 ..< jsonResult.count
            {
                
                jsonElement = jsonResult[i] as! NSDictionary
                
                let location = LocationModel()
                
                //the following insures none of the JsonElement values are nil through optional binding
                if let name = jsonElement["Name"] as? String,
                    let address = jsonElement["Address"] as? String,
                    let latitude = jsonElement["Latitude"] as? String,
                    let longitude = jsonElement["Longitude"] as? String
                {
                    
                    location.name = name
                    location.address = address
                    location.latitude = latitude
                    location.longitude = longitude
                    
                }
                
                locations.add(location)
                
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.delegate.itemsDownloaded(items: locations)
                
            })
        }


    

}
