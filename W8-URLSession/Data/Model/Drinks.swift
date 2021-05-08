//
//  Drinks.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 04/05/2021.
//

import Foundation

struct Drinks: Decodable {
    var drinks: [DrinkItem]?
}

struct DrinkItem: Decodable {
    var idDrink : String?
    var strDrink : String?
    var strDrinkThumb : String?
}
