//
//  MovieSnippetRemote.swift
//  RecruitmentProject
//
//  Created by Piotr Olech on 10/04/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

struct MovieSnippetRemote: Codable {
    let title: String
    let description: String
    let thumbnails: ThumbnailsRemote
}
