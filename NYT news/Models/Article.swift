//
//  Article.swift
//  NYT news
//
//  Created by Ayman Ata on 8/12/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import Foundation


struct Article: Codable {
    let title: String
    let url: String
    let abstract: String
    let multimedia: [ArticleThumbnail]
}
