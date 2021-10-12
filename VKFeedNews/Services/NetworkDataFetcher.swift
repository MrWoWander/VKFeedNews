//
//  NetworkDataFetcher.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 12.10.2021.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkingDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post,photo"]
        
        networking.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print("Error recived requesting data: \(error.localizedDescription)")
                response(nil)
                return
            }
            
            let decoder = decodeJSON(type: FeedResponseWrapper.self, from: data)
            
            response(decoder?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = from,
              let response = try? decoder.decode(type.self, from: data) else { return nil }
        
        return response
    }
}
