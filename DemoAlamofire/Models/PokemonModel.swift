//
//  PokemonModel.swift
//  DemoAlamofire
//
//  Created by Siddhesh P on 20/04/25.
//

import Foundation


struct PokemeonModel: Codable {
    let name:String
    let url:String
}

struct PokemonListResponse: Codable {
    let results: [PokemeonModel]
}
