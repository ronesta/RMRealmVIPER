//
//  Character.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation

struct PostCharacters: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: String
}

struct Location: Decodable {
    let name: String
}
