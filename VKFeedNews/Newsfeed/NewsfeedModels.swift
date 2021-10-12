//
//  NewsfeedModels.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 12.10.2021.
//  Copyright (c) 2021 Mikhail Ivanov. All rights reserved.
//

import UIKit

enum Newsfeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case getFeed
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentNewsfeed
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayNewsfeed
            }
        }
    }
    
}
