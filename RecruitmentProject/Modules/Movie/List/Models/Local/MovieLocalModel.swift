//
//  MovieLocalModel.swift
//  RecruitmentProject
//
//  Created by Piotr Olech on 10/04/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import RealmSwift

class MovieLocalModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var movieDescription: String = ""
    @objc dynamic var imageUrl: String = ""
}
