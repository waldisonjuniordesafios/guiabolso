//
//  ViewController.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 18/02/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rota = Constants.baseURL + EndPoint.categorie.rawValue
        Network.shared.getCategorie(router: rota) { (result, error) in
            print(result)
        }
    }
}

