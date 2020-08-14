//
//  ViewController.swift
//  NYT news
//
//  Created by Ayman Ata on 8/12/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

class NYTNewsVC: UITableViewController {
    
    private var articleViewModels = [ArticleViewModel]()
    private let cellID = "cellId"
    
    private let articleCategories: [ArticleCategory] = [.world, .arts, .us, .science]
    lazy var categories: [String] = articleCategories.map { $0.rawValue }
    lazy var currentCategory = articleCategories[segmentedControl.selectedSegmentIndex]
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: categories)
        sc.backgroundColor = .systemBackground
        sc.selectedSegmentTintColor = .systemPink
        sc.addTarget(self, action: #selector(handleSelectedSegment), for: .valueChanged)
        sc.selectedSegmentIndex = 0
        sc.layer.borderWidth = 2
        sc.layer.borderColor = UIColor.systemGray.cgColor
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(ArticleCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorColor = .clear
        tableView.backgroundColor = .systemBackground
        fetchArticles(wih: currentCategory)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "NY Times"
        self.changeStatusBar(color: .systemPink, in: self)
    }

    // MARK:- tableView funcs
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 295
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ArticleCell
        let articleViewModel = self.articleViewModels[indexPath.section]
        cell.articleViewModel = articleViewModel
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        articleViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        14
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        cell.backgroundColor = .clear
        cell.layer.shadowRadius = 7
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleVM = articleViewModels[indexPath.section]
        let detailedArticleVC = DetailedArticelVC()
        detailedArticleVC.requestArticle(with: articleVM.url, title: currentCategory.rawValue)
        let detailedArticleNavBar = UINavigationController(rootViewController: detailedArticleVC)
        
        present(detailedArticleNavBar, animated: true)
    }
    
    
    // MARK:- other stuff
    private func fetchArticles(wih category: ArticleCategory) {
        NetworkManager.shared.getArticles(for: currentCategory) { [weak self] (result) in
            guard let self = self else {return}
    
            switch result {
            case .success(let articles):
                self.articleViewModels = articles.map { ArticleViewModel(article: $0)}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentNYAlert(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "Ok")
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func handleSelectedSegment() {
        currentCategory = self.articleCategories[segmentedControl.selectedSegmentIndex]
        fetchArticles(wih: currentCategory)
    }
    
    private func changeStatusBar(color: UIColor, in viewController: UIViewController) {
        if #available(iOS 13.0, *) {
            let statusBarHeight: CGFloat = 700
            let statusBarView = UIView()
            statusBarView.backgroundColor = color
            let height = (viewController.navigationController?.navigationBar.frame.height)! + statusBarHeight
            
            statusBarView.frame = CGRect(x: 0, y: -height, width: viewController.view.bounds.width, height: height)
            
            viewController.view.addSubview(statusBarView)
            
        } else {
            let statusBar = UIApplication.shared.value(forKey: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }

}

