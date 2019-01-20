//
//  Tags.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 18/01/19.
//  Copyright © 2019 Carlos Correa. All rights reserved.
//

import Foundation

let tagSports = "ESPORTE"
let tagEconomy = "ECONOMIA"
let tagPolitics = "POLITICA"

struct Tags {
    
    static func getTagSports() -> Bool? {
        return UserDefaults.standard.bool(forKey: tagSports)
    }
    
    static func getTagEconomy () -> Bool? {
        return UserDefaults.standard.bool(forKey: tagEconomy)
    }
    
    static func getTagPolitics() -> Bool? {
        return UserDefaults.standard.bool(forKey: tagPolitics)
    }
    
    static func updateTagSports(_ newValue: Bool) {
        UserDefaults.standard.set(newValue, forKey: tagSports)
    }
    
    static func updateTagEconomy(_ newValue: Bool) {
        UserDefaults.standard.set(newValue, forKey: tagEconomy)
    }
    
    static func updateTagPolitics(_ newValue: Bool) {
        UserDefaults.standard.set(newValue, forKey: tagPolitics)
    }
    
    static func removeTagSports() {
        UserDefaults.standard.removeObject(forKey: tagSports)
    }
    
    static func removeTagEconomy() {
        UserDefaults.standard.removeObject(forKey: tagEconomy)
    }
    
    static func removeTagPolitics() {
        UserDefaults.standard.removeObject(forKey: tagPolitics)
    }
}
