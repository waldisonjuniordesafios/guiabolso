//
//  JokeViewController.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 19/02/21.
//

import UIKit
import Kingfisher

class JokeViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var ivIcone: UIImageView!
    @IBOutlet weak var lblContentJoke: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    
    //MARK: - Properties
    var category = String()
    private var url = ""
    private let dataProvider = JokeDataProvider()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getJokeRandon(category)
        self.setupView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK: - Methods
    private func setupView() {
        self.navigationItem.title = category.capitalized
    }

    private func getJokeRandon(_ category: String) {
        self.dataProvider.delegate = self
        self.dataProvider.getJokeRandon(category)
    }

    @IBAction func openPageJoke(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.seguePageJoke, sender: self.url)
    }
    @IBAction func update(_ sender: UIBarButtonItem) {
        self.getJokeRandon(category)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let jokeUrl = sender as! String? else { return }
        
        if segue.identifier == Constants.seguePageJoke {
            let vc = segue.destination as? PageJokeViewController
            vc?.jokeURL = jokeUrl
        }
    }
}

//MARK: - Extension
extension JokeViewController: JokeDataDelegate {
    func loadJoke(categories: JokeModel) {
        let image = String(categories.iconURL)
        self.ivIcone.kf.setImage(with: URL(string: image), placeholder: UIImage(systemName: "camera"), options: [.keepCurrentImageWhileLoading, .transition(ImageTransition.fade(0.5))], completionHandler: nil)
        self.lblContentJoke.text = categories.value
        self.url = categories.url
        self.ivIcone.kf.indicatorType = .activity
        self.loading.stopAnimating()
    }
}
