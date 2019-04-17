//
//  MovieLocalList.swift
//  RecruitmentProject
//
//  Created by Piotr Olech on 10/04/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import RealmSwift

class MovieLocalList: Object {
    @objc dynamic var recordVersion: Date?
    let movies = List<MovieLocalModel>()
}
