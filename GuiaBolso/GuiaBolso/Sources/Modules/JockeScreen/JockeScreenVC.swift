//
//  JockeScreenVC.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 19/02/21.
//

import UIKit
import Kingfisher

class JockeScreenVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var ivIcone: UIImageView!
    @IBOutlet weak var lblContentJocke: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!


    //MARK: - Properties
    var categorie = String()
    var jocke: JockeModel?


    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getJockeRandon(categorie: categorie)
        self.setupView()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    //MARK: - Methods
    func setupView() {
        self.navigationItem.title = categorie.capitalized
    }

    func getJockeRandon(categorie: String) {
        let rota = Constants.baseURL + EndPoint.random.rawValue + categorie
        Network.shared.getJockeRandon(router: rota) { (data, error) in
            DispatchQueue.main.async {
                self.jocke = data
                self.lblContentJocke.text = self.jocke?.value
                guard let image = self.jocke?.iconURL else { return }
                self.ivIcone.kf.setImage(with: URL(string: image), placeholder: UIImage(systemName: "camera"), options: [.keepCurrentImageWhileLoading, .transition(ImageTransition.fade(0.5))], completionHandler: nil)
            }
            self.ivIcone.kf.indicatorType = .activity
            self.loading.stopAnimating()
        }
    }

    @IBAction func openPageJocke(_ sender: UIButton) {
        self.performSegue(withIdentifier: "PageJacke", sender: self.jocke?.url)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let jocke = sender as! String? else { return }
        
        if segue.identifier == "PageJacke" {
            let vc = segue.destination as? PageJockeScreeVC
            vc?.jocke = jocke
        }
    }
}
