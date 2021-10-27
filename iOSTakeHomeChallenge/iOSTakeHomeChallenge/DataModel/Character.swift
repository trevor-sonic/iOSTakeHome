//
//  Character.swift
//  iOSTakeHomeChallenge
//
//  Created by dejaWorks on 27/10/2021.
//

import Foundation

struct Character: Codable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let aliases:  [String]
    let father: String
    let mother: String
    let spouse: String
    let allegiances: [String]
    let books: [String]
    let povBooks: [String]
    let tvSeries: [String]
    let playedBy: [String]
}
