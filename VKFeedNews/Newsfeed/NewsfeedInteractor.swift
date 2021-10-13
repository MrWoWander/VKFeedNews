//
//  NewsfeedInteractor.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 12.10.2021.
//  Copyright (c) 2021 Mikhail Ivanov. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    
    private var fetcher: DataFetcher = NetworkingDataFetcher(networking: NetworkService())
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
            
        case .getNewsfeed:
            fetcher.getFeed {[weak self] feedResponse in
                guard let feedResponse = feedResponse else { return }
                self?.presenter?.presentData(response: .presentNewsfeed(feed: feedResponse))
            }
        }
    }
}
