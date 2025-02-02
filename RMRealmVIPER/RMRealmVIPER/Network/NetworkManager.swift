//
//  NetworkManager.swift
//  RMRealmVIPER
//
//  Created by Ибрагим Габибли on 02.02.2025.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    var dataCounter = 1
    var imageCounter = 1

    private let urlString = "https://rickandmortyapi.com/api/character"

    private init() {}

    func getCharacters(completion: @escaping ([Character]?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil, NetworkError.invalidURL)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }

            guard let data else {
                print("No data")
                DispatchQueue.main.async {
                    completion(nil, NetworkError.noData)
                }
                return
            }

            do {
                let characters = try JSONDecoder().decode(PostCharacters.self, from: data)
                DispatchQueue.main.async {
                    completion(characters.results, nil)
                    print("Load data \(self.dataCounter)")
                    self.dataCounter += 1
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }

    func loadImage(from urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL for image")
            completion(nil, NetworkError.invalidURL)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Failed to load image: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }

            guard let data else {
                print("No data for image")
                DispatchQueue.main.async {
                    completion(nil, NetworkError.noData)
                }
                return
            }
            DispatchQueue.main.async {
                completion(data, nil)
                print("Load image \(self.imageCounter)")
                self.imageCounter += 1
            }
        }.resume()
    }
}
