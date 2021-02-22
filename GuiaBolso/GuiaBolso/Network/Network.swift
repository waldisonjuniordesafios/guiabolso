//
//  Network.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 18/02/21.
//

import Foundation
import Alamofire


//MARK: - Enum
enum EndPoint: String {
    case categorie = "categories/"
    case random = "random?category="
}

class Network {
    static let shared = Network()

    //MARK: - Methods
    func getCategorie(router: String, completion: @escaping (Category?, Error?) -> Void) {
        AF.request(router).response { response in
            debugPrint(response)
            if response.response?.statusCode != 200 {
                completion(nil, response.error)
            }
            do {
                let result = try JSONDecoder().decode(Category.self, from: response.data!)
                    completion(result, nil)
            } catch {
                print("Erro decoding == \(Error.self)")
                completion(nil, response.error)
            }
        }
    }

    func getJockeRandon(router: String, completion: @escaping (JockeModel?, Error?) -> Void) {
        AF.request(router).response { response in
            debugPrint(response)
            if response.response?.statusCode != 200 {
                print("Service unavailable, try later!")
                completion(nil, response.error)
            }
            do {
                let result = try JSONDecoder().decode(JockeModel.self, from: response.data!)
                    completion(result, nil)
            } catch {
                print(error)
            }
        }
    }
}
