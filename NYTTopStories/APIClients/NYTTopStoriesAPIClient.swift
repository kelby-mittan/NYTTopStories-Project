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
    static func getPix(for city: String, completion: @escaping (Result<TopStories, AppError>) -> ()) {
        
        
        let NYTEndpointURL = ""
        
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
                    let pixHits = topStories
                    completion(.success(pixHits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
