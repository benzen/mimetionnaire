//
//  MimeStore.swift
//  Mime-tionnaire
//
//  Created by Benjamin Dreux on 2014-10-11.
//  Copyright (c) 2014 Benjamin Dreux, Pascal Chouinard. All rights reserved.
//

import Foundation

class MimeStore{
    
    let storeKey = "mime-store"
    
    var store: NSArray
    
    func addMime(mime: MimeModel){
        self.store = self.store.arrayByAddingObject(mime)
    }
        
    init(){

        let userDefaults = NSUserDefaults.standardUserDefaults()
        self.store = userDefaults.objectForKey( storeKey ) as NSArray
        if (self.store.count == 0 ) { self.store = [] }
        userDefaults.setObject(self.store, forKey: self.storeKey)
        userDefaults.synchronize()

    }
}