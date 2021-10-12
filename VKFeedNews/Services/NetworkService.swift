//
//  NetworkService.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 12.10.2021.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], complition: @escaping (Data?, Error?) -> Void)
}

final class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }

        return components.url!
    }
    
    
}

extension NetworkService: Networking {
    func request(path: String, params: [String : String], complition: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else {return}
        
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        let url = url(from: path, params: allParams)
        let request = URLRequest(url: url)
        
        let task = createDataTask(from: request, complition: complition)
        task.resume()
        
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, respone, error in
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
    }
}
