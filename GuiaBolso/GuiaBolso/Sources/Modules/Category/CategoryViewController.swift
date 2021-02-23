//
//  CategoryViewController.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 18/02/21.
//

import UIKit

class CategoryViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwCircle: UIView!
    @IBOutlet weak var lblNumberOfCategorie: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    //MARK: - Properties
    private let dataProvider = CategoryDataProvider()


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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()

        self.tableView.register(UINib(nibName: Constants.cellIDCategory, bundle: nil), forCellReuseIdentifier: Constants.cellIDCategory)

        self.vwCircle.layer.cornerRadius = 8
    }

    private func getCategories() {
        self.dataProvider.delegate = self
        self.dataProvider.getCategories()
        self.dataProvider.setupSearchBar(searchBar: searchBar)
    }
}

//MARK: - Extensions
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.tableView(tableView, numberOfRowsInSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataProvider.tableView(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = dataProvider.selectCategory(tableView, didSelectRowAt: indexPath)
        self.performSegue(withIdentifier: Constants.segueJokeScreen, sender: category)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let category = sender as? String, segue.identifier == Constants.segueJokeScreen, let vc = segue.destination as? JokeViewController else { return }
        vc.category = category
    }
}

extension CategoryViewController: CategoryDataDelegate {
    func updateCount(quantity: Int) {
        self.lblNumberOfCategorie.text = String(quantity)
    }

    func loading(isLoading: Bool) {
        if !isLoading {
            loading.stopAnimating()
        }
    }

    func reloadData() {
        tableView.reloadData()
    }
}
