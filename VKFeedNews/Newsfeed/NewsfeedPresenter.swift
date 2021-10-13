//
//  NewsfeedPresenter.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 12.10.2021.
//  Copyright (c) 2021 Mikhail Ivanov. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
      switch response {
      case .presentNewsfeed(let feed):
          
          let cells = feed.items.map { cellViewModel(from: $0) }
          
          let feedViewModel = FeedViewModel.init(cells: cells)
          viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
      }
  }
  
    private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
        
        return FeedViewModel.Cell.init(iconURLString: "",
                                       name: "future name",
                                       date: "future date",
                                       text: feedItem.text,
                                       comments: String(feedItem.comments?.count ?? 0),
                                       likes: String(feedItem.likes?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0))
    }
    
}
