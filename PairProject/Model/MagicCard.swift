//
//  MagicCard.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import Foundation

struct MagicCard: Codable {
    let cards: [CardWrapper]
    struct CardWrapper: Codable {
        let name: String
        let imageUrl: URL?
        let text: String
        let foreignNames: [foreignNamesWrapper]
    }
}
struct foreignNamesWrapper: Codable{
    let name: String
    let text: String
    let imageUrl: URL
    let language: String
}
