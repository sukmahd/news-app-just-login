//
//  NewsListDetailViewController.swift
//  NewsApp
//
//  Created by Sukmo Ronggo Hadi Wijoyo on 09/12/24.
//

import Foundation
import UIKit

class NewsListDetailViewController: UIViewController {
    private let viewModel: NewsDetailViewModel
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    private lazy var publishDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var publishDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.text = "Published data"
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(viewModel: NewsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configData()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(bannerImageView)
        contentView.addSubview(headlineLabel)
        contentView.addSubview(publishDateLabel)
        contentView.addSubview(publishDateTitleLabel)
        contentView.addSubview(contentLabel)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(self.view).inset(16)
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalToSuperview()
            make.top.leading.equalToSuperview()
        }
        
        headlineLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bannerImageView.snp.bottom).offset(8)
        }
        
        publishDateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headlineLabel.snp.bottom).offset(8)
        }
        
        publishDateTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(publishDateLabel.snp.bottom).offset(16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(publishDateTitleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configData() {
        title = viewModel.getTitle()
        bannerImageView.kf.setImage(with: viewModel.getImageUrl())
        headlineLabel.text = viewModel.getHeadline()
        publishDateLabel.text = viewModel.getPublishedDate()
        contentLabel.text = viewModel.getContent()
    }
}
