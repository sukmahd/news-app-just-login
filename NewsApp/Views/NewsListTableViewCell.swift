//
//  NewsListTableViewCell.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 07/12/24.
//

import Foundation
import UIKit

class NewsListTableViewCell: UITableViewCell {
    private var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description duis of the lorem ipsu si dolor amet queueueueue"
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let timeStapmLabel: UILabel = {
        let label = UILabel()
        label.text = "16/01/2023 - 07:25"
        label.textColor = .systemGray
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubview(contentImageView)
        contentView.addSubview(stackView)
      
        [titleLabel, descriptionLabel, UIView(), timeStapmLabel].forEach { view in
            stackView.addArrangedSubview(view)
        }
        
        contentImageView.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(contentImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
}
