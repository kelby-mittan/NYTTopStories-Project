//
//  NYTTopStoriesAPIClient.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTAPIClient {
    
    static func fetchTopStories(for category: String, completion: @escaping (Result<[Article], AppError>) -> ()) {
        let NYTEndpointURL = "https://api.nytimes.com/svc/topstories/v2/\(category).json?api-key="
        
        guard let url = URL(string: NYTEndpointURL) else {
            completion(.failure(.badURL(NYTEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let topStories = try JSONDecoder().decode(TopStories.self, from: data)
                    let results = topStories.results
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
