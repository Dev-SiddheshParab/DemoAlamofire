//
//  APIError.swift
//  DemoAlamofire
//
//  Created by Siddhesh P on 20/04/25.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case decodingError
    case networkError
    case unknown

    var localizedDescription: String {
        switch self {
        case .invalidResponse: return "Invalid response from the server."
        case .decodingError: return "Failed to decode the response."
        case .networkError: return "Network error occurred."
        case .unknown: return "An unknown error occurred."
        }
    }
}

// APIEndpoints.swift
struct APIEndpoints {
    static let baseURL = "https://pokeapi.co/api/v2"

    static var pokemonList: String {
        return "\(baseURL)/pokemon"
    }

    static func pokemonListPaginated(limit: Int, offset: Int) -> String {
        return "\(baseURL)/pokemon?limit=\(limit)&offset=\(offset)"
    }

    static func pokemonDetail(for name: String) -> String {
        return "\(baseURL)/pokemon/\(name)"
    }
}
