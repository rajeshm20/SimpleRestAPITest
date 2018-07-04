//
//  LocationModel.swift
//  SimpleRestAPITest
//
//  Created by Rajesh on 7/4/18.
//  Copyright © 2018 Rajesh. All rights reserved.
//

import UIKit

class LocationModel: NSObject {
    
    
    var name: String?, address: String?, latitude: String?, longitude: String?;
    
    override init() {
        
    }
    
    init(name: String, address: String, latitude: String, longitude: String){
        
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        
        
    }
    
    
    override var description: String {
        
        return "Name: \(name), Address: \(address), latitude: \(latitude), longitude: \(longitude)"
    }
    

}
