//
//  NetworkManager.swift
//  DemoAlamofire
//
//  Created by Siddhesh P on 20/04/25.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func request<T: Decodable>(
        url: String,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(.networkError))
                }
            }
    }
}
