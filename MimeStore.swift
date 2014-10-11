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
    
    var store: NSMutableArray
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func addMime(mime: MimeModel){
//        self.store = self.store.arrayByAddingObject(mime)
        self.store.insertObject(mime, atIndex: self.store.count)
        println(" nom "+mime.nom+" ")
        userDefaults.synchronize()
    }
        
    init(){
        let data: AnyObject? = userDefaults.objectForKey( storeKey )
        if((data) == nil){
            self.store = []
            userDefaults.setObject(self.store, forKey: self.storeKey)
        }else{
            self.store = data as NSMutableArray
        }
        userDefaults.synchronize()

    }
}