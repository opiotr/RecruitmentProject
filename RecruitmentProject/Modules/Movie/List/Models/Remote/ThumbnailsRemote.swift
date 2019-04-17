//
//  ThumbnailsRemote.swift
//  RecruitmentProject
//
//  Created by Piotr Olech on 10/04/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import Foundation

struct ThumbnailsRemote: Codable {
    let `default`: ThumbnailDetailsRemote
    let medium: ThumbnailDetailsRemote
    let high: ThumbnailDetailsRemote
}
