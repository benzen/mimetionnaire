//
//  MimeStore.swift
//  Mime-tionnaire
//
//  Created by Benjamin Dreux on 2014-10-11.
//  Copyright (c) 2014 Benjamin Dreux. All rights reserved.
//

import Foundation


class MimeStore{

    let tableName = "mime"
    let checkTable = "SELECT name FROM sqlite_master WHERE type='table' AND name='mime';"
    let createTable = "CREATE TABLE mime (nom text, videoUrl text);"
    let insert = "INSERT INTO mime (nom, videoUrl) VALUES (?, ?);"
    let list = "SELECT nom, videoUrl FROM mime;"
    let delete = "DELETE FROM mime where nom=? and videoURL=?;"
    let find = "SELECT nom, videoUrl FROM mime WHERE nom like ?;";
    let db = SQLiteDB.sharedInstance()
    
    func addMime(mime: MimeModel){
        let err = db.execute(insert, parameters: [mime.nom, mime.videoUrl])
        if (err == 0){
            NSLog("ERROR during save of mime\n\(err)")
        }
    }
    
    func listMime(query: String?) -> Array<MimeModel> {
        let resultSet =  query!.isEmpty ? db.query(list) : db.query(find, parameters:["\(query!)%"])
        
        return resultSet.map {
            (row:SQLRow) -> MimeModel in
            let nom = row["nom"]!.asString()
            let videoUrl = row["videoUrl"]!.asString()
            return MimeModel(nom:nom, videoUrl:videoUrl)
        }
    }
    func delete(mime: MimeModel){
        let err = db.execute(delete, parameters: [mime.nom, mime.videoUrl])
        if(err == 0){
            NSLog("ERROR during deleting mime")
        }
    }
    

    init(){
//        let check = db.execute(checkTable)
//        if(check == 0){
//            db.execute(createTable)
//        }
    }
}