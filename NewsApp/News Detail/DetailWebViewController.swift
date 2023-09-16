//
//  DetailWebViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 15.09.2023.
//

import UIKit
import WebKit

class DetailWebViewController: UIViewController {
    var urlString: String?
    @IBOutlet weak var detailWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailWebView.load(URLRequest(url: URL(string: urlString!)!))

    }
}
