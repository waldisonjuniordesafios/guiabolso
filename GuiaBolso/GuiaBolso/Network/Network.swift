//
//  Network.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 18/02/21.
//

import Foundation
import Alamofire

enum EndPoint: String {
    case categorie = "categories/"
    case random = "random?category="
}

class Network {
    static let shared = Network()

    func getCategorie(router: String, completion: @escaping (Category?, Error?) -> Void) {
        AF.request(router).response { response in
            debugPrint(response)
            if response.response?.statusCode != 200 {
                print("ERROR")
                completion(nil, response.error)
            }
            do {
                let result = try JSONDecoder().decode(Category.self, from: response.data!)
                if result != nil {
                    completion(result, nil)
                }
            } catch {
                print(error)
            }
        }
    }

    func getJockeRandon(router: String, completion: @escaping (JockeModel?, Error?) -> Void) {
        AF.request(router).response { response in
            debugPrint(response)
            if response.response?.statusCode != 200 {
                print("ERROR")
                completion(nil, response.error)
            }
            do {
                let result = try JSONDecoder().decode(JockeModel.self, from: response.data!)
                if result != nil {
                    completion(result, nil)
                } else {
                    print("ERROR")
                }
            } catch {
                print(error)
            }
        }
    }
}
