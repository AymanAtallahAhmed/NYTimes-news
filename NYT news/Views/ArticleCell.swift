//
//  ArticleCell.swift
//  NYT news
//
//  Created by Ayman Ata on 8/12/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    var articleViewModel: ArticleViewModel! {
        didSet {
            articleTitleLabel.text = articleViewModel.title
            articleAbstract.text = articleViewModel.abstract
            //articleImageView.image = articleViewModel.thumbImage
            NetworkManager.shared.getArticleImage(for: articleViewModel.multimedia[3].url) { (image) in
                DispatchQueue.main.async {
                    self.articleImageView.image = image
                }
            }
        }
    }
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.345890411)
        return label
    }()
    
    let articleAbstract: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 5
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        let padding: CGFloat = 12
        addSubview(container)
        addSubview(articleImageView)
        addSubview(articleTitleLabel)
        addSubview(articleAbstract)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            articleImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 1),
            articleImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 190),
            
            articleTitleLabel.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor),
            articleTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            articleTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            
            articleAbstract.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 4),
            articleAbstract.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            articleAbstract.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            articleAbstract.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -4)
        ])
        
    }
    
}
