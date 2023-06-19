//
//  DBManager.swift
//  ExamenCocktail
//
//  Created by MacBookMBA4 on 16/06/23.
//

import Foundation
import SQLite3

public class DBManager {
    var result = Result()
    
    let dbPath: String = "DBCocktail.sqlite"
    var db:OpaquePointer?
    
    init()
    {
        db = Get()
    
    }
    
    
    
    func Get() -> OpaquePointer?
    {
        
       // let storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.EAguilarEcommerce")!.appendingPathComponent(path)
        
        let filePath = try! FileManager.default.url(for:
                .documentDirectory, in:
                .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
//        let filePathCompartido = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.EGarciaEcommerce")!.appendingPathComponent(dbPath)
//
//                print(filePathCompartido)
              // print(filePath)
        
        //var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            print("fallo la conexion")
            return nil
        }
        else
        {
            print("conexion existosa el pat: \(filePath)")
            //result.Correct = true
            return db
        }
    }
}
