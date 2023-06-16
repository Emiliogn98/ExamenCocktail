//
//  DrinkSqliteViewModel.swift
//  ExamenCocktail
//
//  Created by Emilio García Navarrete on 16/06/23.
//

import Foundation
import SQLite3

class DrinkSqliteViewModel {
    
    static func Add(drink : Drinks) -> Result{
            var context = DBManager()
            var result = Result()
            let query = "INSERT INTO Drinks(strfCategory,strDrink,strDrinkThumb,strAlcoholic,strIngredient1,strIngredient2,strIngredient3,strMeasure1,strMeasure2,strMeasure3) VALUES('?,?,?,?,?,?,?,?,?,?)"

            var statement: OpaquePointer? = nil
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {

                    sqlite3_bind_text(statement, 1, (drink.strCategory! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 2, (drink.strDrink! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 3, (drink.strDrinkThumb! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 4, (drink.strAlcoholic! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 5, (drink.strIngredient1! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 6, (drink.strIngredient2! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 7, (drink.strIngredient3! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 8, (drink.strMeasure1! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 9, (drink.strMeasure2! as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(statement, 10, (drink.strMeasure3! as NSString).utf8String, -1, nil)



                    if try sqlite3_step(statement) == SQLITE_DONE {
                        print("favorito insertado.")
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
