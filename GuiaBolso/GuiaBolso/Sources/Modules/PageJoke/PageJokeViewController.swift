//
//  PageJokeViewController.swift
//  GuiaBolso
//
//  Created by Junior Fernandes on 19/02/21.
//

import UIKit
import WebKit

class PageJokeViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    //MARK: - Properties
    var jokeURL: String?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWebView()
    }

    private func setupWebView() {
        guard let joke = jokeURL else { return }
        let urlString = "\(joke)"
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
extension PageJokeViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
