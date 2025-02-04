//
//  StorageManagerProtocol.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 04.02.2025.
//

import Foundation

protocol StorageManagerProtocol {
    func saveCharacters(_ characters: [(character: Character, imageData: Data?)])

    func fetchCharacters() -> [RealmCharacter]

    func fetchImageData(forCharacterId id: Int) -> Data?
}
