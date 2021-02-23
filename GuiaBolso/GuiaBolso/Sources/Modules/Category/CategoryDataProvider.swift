//
//  CategoryDataProvider.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 22/02/21.
//

import Foundation
import UIKit

//MARK: - Protocol
protocol CategoryDataDelegate: class {
    func reloadData()   
    func loading(isLoading: Bool)
    func updateCount(quantity: Int)
}

class CategoryDataProvider: NSObject {
    //MARK: - Properties
    weak var delegate: CategoryDataDelegate?
    private var searchCategories = [String]()
    private var categoriesCount: Int = 0
    private var categories: [String]? {
        didSet {
            self.searchCategories = self.categories ?? []
            self.delegate?.updateCount(quantity: searchCategories.count)
            self.delegate?.reloadData()
        }
    }

    //MARK: - Methods
    func getCategories() {
        let router = Constants.baseURL + EndPoint.categories.rawValue
        Network().getCategorie(router: router) { (data, error) in
            guard let data = data else {
                print("Error")
                return
            }
            self.categories = data
            self.delegate?.loading(isLoading: false)
        }
    }

    func numberOfRowsInSection() -> Int {
        if self.searchCategories.count > 0 {
            return self.searchCategories.count
        } else {
            return 0
        }
    }

    func setupSearchBar(searchBar: UISearchBar) {
        searchBar.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchCategories.count > 0 {
            return self.searchCategories.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searchCategories.count > 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIDCategory, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell()
            }
            cell.setupCell(category: searchCategories, indexPath: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }

    func selectCategory(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> String {
        return self.searchCategories[indexPath.row]
    }
}

//MARK: - Extensions
extension CategoryDataProvider: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCategories = []
        if searchText.isEmpty {
            self.searchCategories = self.categories ?? []
            self.delegate?.updateCount(quantity: searchCategories.count)
        } else {
            guard let categories = categories else { return }
            for category in categories {
                if category.lowercased().contains(searchText.lowercased()) {
                    self.searchCategories.append(category)
                    self.delegate?.updateCount(quantity: searchCategories.count)
                } else {
                    self.delegate?.updateCount(quantity: searchCategories.count)
                }
            }
        }
        self.delegate?.reloadData()
    }
}
