//
//  NetworkLayer.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 21.08.2023.
//

import Foundation

class NetworkLayer {
    func dataTransformation<T: Decodable>(object: inout T, data: Data) {
        let decoder = JSONDecoder()
        do{
            object = try decoder.decode(T.self, from: data)
        } catch let error as NSError {
            print("Ошибка при преобразовании:: \(error)")
        }
    }
    
    func loadData(url: URL?, _ completion: @escaping (_ success: Bool, _ data: Data?) -> Void) {
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared

        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(true, data)
            } else {
                completion(false, nil)
            }
        }
        task.resume()
    }
}
