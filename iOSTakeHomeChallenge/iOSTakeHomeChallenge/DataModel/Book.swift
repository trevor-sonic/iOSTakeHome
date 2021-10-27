//
//  Book.swift
//  iOSTakeHomeChallenge
//
//  Created by dejaWorks on 27/10/2021.
//

import Foundation

protocol ThroneData: Codable {}

struct Book: ThroneData {
    
    let url: String
    let name: String
    let isbn: String
    let authors: [String]
    let numberOfPages: Int
    let publisher: String
    let country: String
    let mediaType: String
    let released: String
    let characters: [String]
    
}
