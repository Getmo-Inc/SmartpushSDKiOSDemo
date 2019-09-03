//
//  CSSProfileCached.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 29/07/19.
//  Copyright © 2019 Carlos Correa. All rights reserved.
//

import Foundation

class CSSProfileCached {
        
    func cachedObject() -> NSDictionary? {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        var nsDictionary: NSDictionary?
        
        if let pathComponent = url.appendingPathComponent("kBWS_PROFILE.json") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                nsDictionary = NSDictionary(contentsOfFile: filePath)
            }
        }
        
        return nsDictionary
    }
    
}
