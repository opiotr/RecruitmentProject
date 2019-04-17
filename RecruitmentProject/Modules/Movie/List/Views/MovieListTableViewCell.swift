//
//  MovieListTableViewCell.swift
//  RecruitmentProject
//
//  Created by Piotr Olech on 10/04/2019.
//  Copyright © 2019 Piotr Olech. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupPhotoImageView()
    }
    
    // MARK: - Setup
    
    private func setupCellView() {
        selectionStyle = .none
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupPhotoImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
    }
    
    // MARK: - Access methods
    
    func setup(with data: MovieListCellData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        photoImageView.kf.setImage(with: data.imageUrl)
    }
}
