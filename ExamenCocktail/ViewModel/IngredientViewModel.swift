//
//  IngredientViewModel.swift
//  ExamenCocktail
//
//  Created by Emilio García Navarrete on 15/06/23.
//

import Foundation
class IngredientViewModel {

    static func GetById (idIngredient: Int,responseResult : @escaping(Ingredient?,Error?) -> Void) {

        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=\(idIngredient)")!
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let dataSource = data{
                let decoder = JSONDecoder()
                let result =  try!
                decoder.decode(Ingredient.self, from: dataSource)
                responseResult(result,nil)
            }
            if let errorSource = error{
                responseResult(nil,errorSource)
            }

        }.resume()

        //  return result
    }
    static func GetByName (nombreIngrediente: Int,responseResult : @escaping(Ingredient?,Error?) -> Void) {

        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?i=\(nombreIngrediente)")!
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let dataSource = data{
                let decoder = JSONDecoder()
                let result =  try!
                decoder.decode(Ingredient.self, from: dataSource)
                responseResult(result,nil)
            }
            if let errorSource = error{
                responseResult(nil,errorSource)
            }

        }.resume()

        //  return result
    }
}
