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
    case categories = "categories/"
    case random = "random?category="
}

class Network {

    //MARK: - Methods
    func getCategorie(router: String, completion: @escaping (Categories?, Error?) -> Void) {
        AF.request(router).response { response in
            debugPrint(response)
            guard let data = response.data, response.response?.statusCode == 200 else {
                completion(nil, response.error)
                print("Service unavailable, try later!")
                return
            }
            do {
                let result = try JSONDecoder().decode(Categories.self, from: data)
                    completion(result, nil)
            } catch {
                print("Erro decoding == \(Error.self)")
                completion(nil, response.error)
            }
        }
    }

    func getJokeRandon(router: String, completion: @escaping (JokeModel?, Error?) -> Void) {
        AF.request(router).response { response in
            debugPrint(response)
            guard let data = response.data, response.response?.statusCode == 200 else {
                completion(nil, response.error)
                print("Service unavailable, try later!")
                return
            }
            do {
                let result = try JSONDecoder().decode(JokeModel.self, from: data)
                    completion(result, nil)
            } catch {
                print(error)
            }
        }
    }
}
