//
//  JokeModel.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 19/02/21.
//

import UIKit
import Kingfisher

class JokeScreenVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var ivIcone: UIImageView!
    @IBOutlet weak var lblContentJoke: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    
    //MARK: - Properties
    var category = String()
    private var joke: JokeModel?

    private enum Strings {
        static let seguePageJoke = "PageJoke"
    }


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
        let rota = Constants.baseURL + EndPoint.random.rawValue + category
        Network.shared.getJokeRandon(router: rota) { (data, error) in
            DispatchQueue.main.async {
                self.joke = data
                self.lblContentJoke.text = self.joke?.value
                guard let image = self.joke?.iconURL else { return }
                self.ivIcone.kf.setImage(with: URL(string: image), placeholder: UIImage(systemName: "camera"), options: [.keepCurrentImageWhileLoading, .transition(ImageTransition.fade(0.5))], completionHandler: nil)
            }
            self.ivIcone.kf.indicatorType = .activity
            self.loading.stopAnimating()
        }
    }

    @IBAction func openPageJoke(_ sender: UIButton) {
        self.performSegue(withIdentifier: Strings.seguePageJoke, sender: self.joke?.url)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let jokeUrl = sender as! String? else { return }
        
        if segue.identifier == Strings.seguePageJoke {
            let vc = segue.destination as? PageJokeScreenVC
            vc?.jokeURL = jokeUrl
        }
    }
}
