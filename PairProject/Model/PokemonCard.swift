//
//  PokemonCard.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import Foundation

struct PokemonCard: Codable {
    let cards: [CardWrapper]
    struct CardWrapper: Codable {
        let imageURL: URL?
        let imageUrlHiRes: URL
        let attacks: [Attacks]
    }


}

struct Attacks: Codable {

    let name: String
    let damage: String
    let text: String

}
