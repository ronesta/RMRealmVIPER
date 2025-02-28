//
//  StorageManager.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation
import RealmSwift

final class StorageManager: NSObject, StorageManagerProtocol {
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }

    // swiftlint:disable:next function_parameter_count
    public func createOrUpdateCharacter(id: Int,
                                        gender: String,
                                        image: String,
                                        location: String,
                                        name: String,
                                        species: String,
                                        status: String,
                                        imageData: Data?) {
        let character = RealmCharacter()
        character.id = id
        character.gender = gender
        character.image = image
        character.location = location
        character.name = name
        character.species = species
        character.status = status
        character.imageData = imageData

        do {
            try realm.write {
                realm.add(character, update: .modified)
            }
        } catch {
            print("Error saving character: \(error)")
        }
    }

    func saveCharacters(_ characters: [(character: Character, imageData: Data?)]) {
        for (character, imageData) in characters {
            createOrUpdateCharacter(
                id: character.id,
                gender: character.gender,
                image: character.image,
                location: character.location.name,
                name: character.name,
                species: character.species,
                status: character.status,
                imageData: imageData
            )
        }
    }

    public func fetchCharacters() -> [RealmCharacter] {
        return Array(realm.objects(RealmCharacter.self))
    }

    func fetchImageData(forCharacterId id: Int) -> Data? {
        realm.object(ofType: RealmCharacter.self, forPrimaryKey: id)?.imageData
    }
}
