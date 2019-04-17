//
//  ViewController.swift
//  RecruitmentProject
//
//  Created by Piotr Olech on 10/04/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private let viewModel: MovieListViewModel = MovieListViewModel()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SciTube"
        
        setupTableView()
        setupBindings()
        viewModel.loadData()
    }

    // MARK: - Setup
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: MovieListTableViewCell.self), bundle: .main), forCellReuseIdentifier: String(describing: MovieListTableViewCell.self))
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Data binding
    
    private func setupBindings() {
        viewModel.onDataChange = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.dataList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListTableViewCell.self)) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: data)
        return cell
    }
}
