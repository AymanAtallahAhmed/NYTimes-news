//
//  ArticleViewModel.swift
//  NYT news
//
//  Created by Ayman Ata on 8/13/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit


class ArticleViewModel {
    
    var title: String
    var url: String
    var abstract: String
    var multimedia: [ArticleThumbnail]
    var thumbImage: UIImage!

    init(article: Article) {
        self.title = article.title
        self.url = article.url
        self.abstract = article.abstract
        self.multimedia = article.multimedia
        
        //fetchThumbnails()
    }
    
    
    func fetchThumbnails() {
        NetworkManager.shared.getArticleImage(for: multimedia[3].url) { [weak self] (image) in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.thumbImage = image
            }
        }
    }
    
}
