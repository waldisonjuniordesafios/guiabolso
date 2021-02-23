//
//  JokeDataProvider.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 22/02/21.
//

import Foundation

//MARK: - Protocol
protocol JokeDataDelegate: class {
    func loadJoke(categories: JokeModel)
}

class JokeDataProvider {
    //MARK: - Properties
    weak var delegate: JokeDataDelegate?
    var category = String()

    //MARK: - Methods
    func getJokeRandon(_ category: String) {
        let rota = Constants.baseURL + EndPoint.random.rawValue + category
        Network().getJokeRandon(router: rota) { (data, error) in
            guard let data = data else {
                print("Error")
                return
            }
            self.delegate?.loadJoke(categories: data)
        }
    }
}
