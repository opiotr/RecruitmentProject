//
//  MovieListViewModel.swift
//  RecruitmentProject
//
//  Created by Piotr Olech on 10/04/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import RealmSwift

class MovieListViewModel {
    
    // MARK: - Public properties
    
    var onDataChange: (() -> Void)?
    var dataList: [MovieListCellData] = []
    
    // MARK: - Data loading
    
    func loadData() {
        let data = loadDataFromDatabase()

        if let data = data, !isReloadDataNeeded(recordVersion: data.recordVersion) {
            prepareDataForView(with: Array(data.movies))
        } else {
            loadDataFromWebservice()
        }
    }
    
    private func loadDataFromWebservice() {
        let path = "channels.json"
        let endpoint = Endpoint<MovieListRemote>(path: path)
        
        HTTPClient.shared.request(endpoint, success: { [weak self] data in
            let localDataList = self?.createLocalMovieModelList(with: data.items) ?? []
            self?.saveDataInDatabase(data: localDataList)
            self?.prepareDataForView(with: localDataList)
        }, failure: { error in
            debugPrint(error)
        })
    }
    
    private func loadDataFromDatabase() -> MovieLocalList? {
        let realm = try? Realm()
        let objects = realm?.objects(MovieLocalList.self)
        return objects?.first
    }
    
    private func isReloadDataNeeded(recordVersion: Date?) -> Bool {
        guard let recordVersion = recordVersion else { return true }
        
        let reloadDataInterval: TimeInterval = 5 * 60
        let currentDate = Date()
        
        return recordVersion.addingTimeInterval(reloadDataInterval) <= currentDate
    }
    
    // MARK: - Persisting data
    
    private func saveDataInDatabase(data: [MovieLocalModel]) {
        let realm = try? Realm()
        
        let movieLocalList = MovieLocalList()
        movieLocalList.recordVersion = Date()
        movieLocalList.movies.append(objectsIn: data)
        try? realm?.write {
            realm?.deleteAll()
            realm?.add(movieLocalList)
        }
    }
    
    private func createLocalMovieModelList(with data: [MovieItemRemote]) -> [MovieLocalModel] {
        let dataList = data.map { item -> MovieLocalModel in
            let model = MovieLocalModel()
            model.title = item.snippet.title
            model.movieDescription = item.snippet.description
            model.imageUrl = item.snippet.thumbnails.high.url
            return model
        }
        return dataList
    }
    
    // MARK: - Preparing data
    
    private func prepareDataForView(with data: [MovieLocalModel]) {
        let cellDataList = createCellDataList(with: data)
        dataList = cellDataList
        onDataChange?()
    }
    
    private func createCellDataList(with items: [MovieLocalModel]) -> [MovieListCellData] {
        let cellDataList = items
            .map { item -> MovieListCellData in
                let url = URL(string: item.imageUrl)
                return MovieListCellData(title: item.title,
                                         description: item.movieDescription,
                                         imageUrl: url)
            }
            .sorted(by: { $0.description < $1.description })
        
        return cellDataList
    }
}
