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
  
  }
  
}
