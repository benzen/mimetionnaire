//
//  MimeStore.swift
//  Mime-tionnaire
//
//  Created by Benjamin Dreux on 2014-10-11.
//  Copyright (c) 2014 Benjamin Dreux, Pascal Chouinard. All rights reserved.
//

import Foundation


class MimeStore{

    let tableName = "mime"
    let checkTable = "SELECT name FROM sqlite_master WHERE type='table' AND name='mime';"
    let createTable = "CREATE TABLE mime (nom text, videoUrl text);"
    let insert = "INSERT INTO mime (nom, videoUrl) VALUES (?, ?);"
    let list = "SELECT nom, videoUrl FROM mime;"
    let db = SQLiteDB.sharedInstance()
    
    func addMime(mime: MimeModel){
        let err = db.execute(insert, parameters: [mime.nom, mime.videoUrl])
        if (err == 0){
            NSLog("ERROR during save of mime\n\(err)")
        }
    }
    
    func listMime() -> Array<MimeModel> {
        let resultSet = db.query(list)
        return resultSet.map {
            (row:SQLRow) -> MimeModel in
            let nom = row["nom"]!.asString()
            let videoUrl = row["videoUrl"]!.asString()
            return MimeModel(nom:nom, videoUrl:videoUrl)
        }
    }
    

    init(){
//        let check = db.execute(checkTable)
//        if(check == 0){
//            db.execute(createTable)
//        }
    }
}