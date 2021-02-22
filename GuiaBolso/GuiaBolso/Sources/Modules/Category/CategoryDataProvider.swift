//
//  CategoryDataProvider.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 22/02/21.
//

import Foundation


protocol CategoryDataDelegate: class {
    func loadCategories(categories: Categories)
}

class CategoryDataProvider {
    weak var delegate: CategoryDataDelegate?

    func getCategories() {
        let router = Constants.baseURL + EndPoint.categories.rawValue
        Network().getCategorie(router: router) { (data, error) in
            guard let data = data else {
                print("Error")
                return
            }
            self.delegate?.loadCategories(categories: data)
        }
    }
}