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
    
    var cellLayaoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        
        return dt
    }()
    
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsfeed(let feed):
            
            let cells = feed.items.map { cellViewModel(from: $0, profiles: feed.profiles, groups: feed.groups) }
            
            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        
        let profile = profile(sourceId: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let photoAttachment = photoAttachment(feedItem: feedItem)
        
        let sizes = cellLayaoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachment)
        
        return FeedViewModel.Cell.init(iconURLString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       comments: String(feedItem.comments?.count ?? 0),
                                       likes: String(feedItem.likes?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachment: photoAttachment,
                                       sizes: sizes)
    }
    
    private func profile(sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceId > 0 ? profiles : groups
        
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        
        return profilesOrGroups.first(where: { $0.id == normalSourceId })!
        
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({$0.photo}),
              let firstPhoto = photos.first
        else { return nil }
        
        return FeedViewModel.FeedCellPhotoAttachment.init(photoURLString: firstPhoto.srcURL,
                                                          width: firstPhoto.widht,
                                                          height: firstPhoto.height)
    }
    
}
