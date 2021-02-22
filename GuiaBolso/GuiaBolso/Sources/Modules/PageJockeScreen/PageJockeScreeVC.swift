//
//  PageJockeScreeVC.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 19/02/21.
//

import UIKit
import WebKit

class PageJockeScreeVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    //MARK: - Properties
    var jocke: String?

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "\(jocke!)"
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)

        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.load(request)
    }

    //MARK: - Methods
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extension
extension PageJockeScreeVC: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
