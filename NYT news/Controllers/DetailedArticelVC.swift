//
//  DetailedArticelVC.swift
//  NYT news
//
//  Created by Ayman Ata on 8/13/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit
import WebKit

class DetailedArticelVC: UIViewController {
    
    private let webView = WKWebView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func requestArticle(with url: String, title: String) {
        navigationItem.title = title
        guard let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }

    
    private func setupUI() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().barTintColor = .systemPink
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
}
