//
//  DrinkSqliteViewModel.swift
//  ExamenCocktail
//
//  Created by Emilio García Navarrete on 16/06/23.
//

import Foundation
import SQLite3

class DrinkSqliteViewModel {
    
    static func Add(categoria : Drink) -> Result{
            var context = DBManager()
            var result = Result()
            let query = "INSERT INTO Producto (Nombre,PrecioUnitario,Stock,Descripcion,Imagen,IdProveedor,IdDepartamento) VALUES(?,?,?,?,?,?,?)"
            var statement: OpaquePointer? = nil
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {

//                    sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
//                    sqlite3_bind_double(statement, 2, Double(producto.PrecioUnitario! as Double))
//                    sqlite3_bind_int(statement, 3, Int32(producto.Stock! as Int))
//                    sqlite3_bind_text(statement, 4, (producto.Descripcion! as NSString).utf8String, -1, nil)
//                    sqlite3_bind_text(statement, 5, (producto.Imagen! as NSString).utf8String, -1, nil)
//                    sqlite3_bind_int(statement, 6, Int32(producto.Proveedor!.IdProveedor! as Int))
//                    sqlite3_bind_int(statement, 7, Int32(producto.Departamento!.IdDepartamento! as Int))


                    if try sqlite3_step(statement) == SQLITE_DONE {
                        print("Producto insertado.")
                        result.Correct = true
                    } else {
                        print("ocurrio un error al insertar")
                        result.Correct = false
                    }
                }
                sqlite3_finalize(statement)
                sqlite3_close(context.db)
            }
            catch let ex {
                result.Correct = false
                result.ErrorMessage = ex.localizedDescription
                result.Ex = ex
            }
            return result

        }
}
