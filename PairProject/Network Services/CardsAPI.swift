//
//  CardsAPI.swift
//  PairProject
//
//  Created by Jabeen's MacBook on 1/9/19.
//  Copyright © 2019 Jabeen's MacBook. All rights reserved.
//

import Foundation
final class CardsAPI{
    static func getMagicCards (completionHandler: @escaping(AppError?,[MagicCard.CardWrapper]?) -> Void){
    NetworkHelper.shared.performDataTask(endpointURLString:"https://api.magicthegathering.io/v1/cards?contains=imageUrl") { (appError, data, httpResponse) in
        if let appError = appError {
            completionHandler(appError, nil)
        }
        if let data = data{
            do{
               let magicCardData = try JSONDecoder().decode(MagicCard.self, from: data)
                completionHandler(nil, magicCardData.cards)
            }catch{
                completionHandler(AppError.decodingError(error), nil)
            }
        }
    }
}
    static func getPokemonCards (completionHandler: @escaping(AppError?,[PokemonCard.PokemonCardWrapper]?) -> Void){
        NetworkHelper.shared.performDataTask(endpointURLString:"https://api.pokemontcg.io/v1/cards?contains=imageUrl,imageUrlHiRes,attacks") { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            if let data = data{
                do{
                    let pokemonCardData = try JSONDecoder().decode(PokemonCard.self, from: data)
                    completionHandler(nil, pokemonCardData.cards)
                }catch{
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
}
