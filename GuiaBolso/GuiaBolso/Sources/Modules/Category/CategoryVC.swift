//
//  CategoryVC.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 18/02/21.
//

import UIKit

class CategoryVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwCircle: UIView!
    @IBOutlet weak var lblNumberOfCategorie: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    //MARK: - Properties
    private var categories: [String]? {
        didSet {
            self.searchCategories = self.categories ?? []
            self.lblNumberOfCategorie.text = String(self.searchCategories.count)
            self.tableView.reloadData()
            self.loading.stopAnimating()
        }
    }
    private var searchCategories = [String]()
    private var categoriesCount: Int = 0
    private let dataProvider = CategoryDataProvider()

    private enum Strings {
        static let cellID = "CategoryTableViewCell"
        static let segueJokeScreen = "JokeScreen"
        static let defaultTitle = "Error"
        static let defaultMessage = "Service unavailable, try later!"
        static let defaultButton = "Ok"
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.getCategories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    //MARK: - Methods
    private func setupTableView() {
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()

        self.tableView.register(UINib(nibName: Strings.cellID, bundle: nil), forCellReuseIdentifier: Strings.cellID)

        self.vwCircle.layer.cornerRadius = 8
    }

    private func getCategories() {
        dataProvider.delegate = self
        dataProvider.getCategories()
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.defaultButton, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func countCategories() {
        self.lblNumberOfCategorie.text = String(self.searchCategories.count)
    }
}

//MARK: - Extensions
extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchCategories.count > 0 {
            return self.searchCategories.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searchCategories.count > 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cellID, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell()
            }
            cell.lblCategoryName.text = searchCategories[indexPath.row].capitalized
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var categorie = String()
        categorie = self.searchCategories[indexPath.row]
        self.performSegue(withIdentifier: Strings.segueJokeScreen, sender: categorie)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let category = sender as? String, segue.identifier == Strings.segueJokeScreen, let vc = segue.destination as? JokeVC else { return }
        vc.category = category
    }
}

extension CategoryVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCategories = []
        if searchText.isEmpty {
            self.searchCategories = self.categories ?? []
            self.countCategories()
        } else {
            guard let categories = categories else { return }
            for category in categories {
                if category.lowercased().contains(searchText.lowercased()) {
                    searchCategories.append(category)
                    self.countCategories()
                } else {
                    self.countCategories()
                }
            }
        }
        self.tableView.reloadData()
    }
}

extension CategoryVC: CategoryDataDelegate {
    func loadCategories(categories: Categories) {
        self.categories = categories
    }
}
