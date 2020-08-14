//
//  NYError.swift
//  NYT news
//
//  Created by Ayman Ata on 8/12/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import Foundation

enum NYError: String, Error {
    case invalidURL = "This URL created invalid request, please try againg"
    case unableToComplete = "Unable to complete your request, Please check your internet connection"
    case invalidData = "Invaled data recived from the server, Please try again."
    case invalidResponse = "Invalid response from the server, Plase try again."
}
