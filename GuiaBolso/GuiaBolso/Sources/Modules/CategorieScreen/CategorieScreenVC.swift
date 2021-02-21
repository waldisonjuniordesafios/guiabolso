//
//  CategorieScreenVC.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 18/02/21.
//

import UIKit

class CategorieScreenVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwCircle: UIView!
    @IBOutlet weak var lblNumberOfCategorie: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    //MARK: - Properties
    fileprivate var categories = [String]()
    fileprivate var searchCategories = [String]()
    fileprivate var categoriesCount: Int = 0

    let cellID = "CategorieTableViewCell"

    //MARK: - Life cycle
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
    fileprivate func setupTableView() {
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()

        self.tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)

        self.vwCircle.layer.cornerRadius = 16/2
    }

    fileprivate func getCategories() {
        let router = Constants.baseURL + EndPoint.categorie.rawValue
        Network.shared.getCategorie(router: router) { (data, error) in
            guard error == nil else{
                return
            }
            self.categories.append(contentsOf: data!!)
            self.searchCategories.append(contentsOf: data!!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchCategories = self.categories
                self.lblNumberOfCategorie.text = String(self.searchCategories.count)
            }
            self.loading.stopAnimating()
        }
    }

    fileprivate func countCategories() {
        self.lblNumberOfCategorie.text = String(self.searchCategories.count)
    }
}

//MARK: - Extensions
extension CategorieScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchCategories.count > 0 {
            return self.searchCategories.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searchCategories.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CategorieTableViewCell
            cell.lblCategorieName.text = searchCategories[indexPath.row].capitalized
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = "No results"
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var categorie = String()
        categorie = self.searchCategories[indexPath.row]
        self.performSegue(withIdentifier: "JockeScreen", sender: categorie)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "JockeScreen" {
            let vc = segue.destination as? JockeScreenVC
            vc?.categorie = sender! as! String
        }
    }
}

extension CategorieScreenVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchCategories = []
        if searchText.isEmpty {
            self.searchCategories = self.categories
            self.countCategories()
        } else {
            for a in categories {
                if a.lowercased().contains(searchText.lowercased()) {
                    searchCategories.append(a)
                    self.countCategories()
                } else {
                    self.countCategories()
                }
            }
        }
        self.tableView.reloadData()
    }
}

