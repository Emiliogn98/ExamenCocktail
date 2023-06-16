//
//  Drink.swift
//  ExamenCocktail
//
//  Created by MacBookMBA4 on 15/06/23.
//

import Foundation
struct Drink: Codable {

var drinks : [Drinks]? = []

}

struct Drinks: Codable {

        var strCategory : String? = nil
        var idDrink : String? = nil
        var strDrink : String? = nil
        var strDrinkThumb: String? = nil
        var strAlcoholic : String? = nil
        var strIngredient1 : String? = nil
        var strIngredient2 : String? = nil
        var strIngredient3 : String? = nil
        var strMeasure1 : String? = nil
        var strMeasure2 : String? = nil
        var strMeasure3 : String? = nil
    



}
