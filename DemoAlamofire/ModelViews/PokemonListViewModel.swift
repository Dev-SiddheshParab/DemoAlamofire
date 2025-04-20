//
//  PokemonListViewModel.swift
//  DemoAlamofire
//
//  Created by Siddhesh P on 20/04/25.
//

import Foundation

class PokemonListViewModel {
    var pokemons: [PokemeonModel] = [] {
        didSet {
            self.onDataUpdate?(pokemons)
        }
    }

    var onDataUpdate: (([PokemeonModel]) -> Void)?
    var onError: ((String) -> Void)?

    private var isLoading = false
    private var offset = 0
    private let limit = 20

    func fetchPokemonList(reset: Bool = false) {
        guard !isLoading else { return }
        isLoading = true

        if reset {
            offset = 0
            pokemons = []
        }

        let url = APIEndpoints.pokemonListPaginated(limit: limit, offset: offset)

        NetworkManager.shared.request(url: url) { [weak self] (result: Result<PokemonListResponse, APIError>) in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let response):
                self.offset += self.limit
                self.pokemons += response.results
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    }
}
