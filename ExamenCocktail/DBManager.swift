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
        createTable()
    
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
    func createTable() {
        let queryTable = "CREATE TABLE IF NOT EXISTS Drinks (idDrink INTEGER NOT NULL,strCategory VARCHAR ,strDrink VARCHAR,strDrinkThumb VARCHAR,strAlcoholic VARCHAR(150),strIngredient1 VARCHAR,strIngredient2 VARCHAR,strIngredient3 VARCHAR,strMeasure1 VARCHAR,strMeasure2 VARCHAR,strMeasure3 VARCHAR,PRIMARY KEY('idDrink' AUTOINCREMENT))"
        
        if sqlite3_exec(db,queryTable,nil,nil,nil) != SQLITE_OK {
         print("ocurrio un error al crear la tabla")
        }
    }
}
