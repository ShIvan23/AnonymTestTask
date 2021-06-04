//
//  FeedDetailViewController.swift
//  AnonymTestTask
//
//  Created by Ivan on 03.06.2021.
//

import UIKit

final class FeedDetailViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private(set) var viewModel: FeedDetailViewModelProtocol
    
    private lazy var mainView = FeedDetailView()
    
    // MARK: - Initializers
    
    init(viewModel: FeedDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        mainView.authorNameLabel.text = viewModel.authorName
        mainView.likesLabel.text = viewModel.likes
        if let authorImageURL = viewModel.authorImage {
            mainView.authorImageView.loadImage(by: authorImageURL)
        }
        if let postImageURL = viewModel.postImage {
            mainView.postImageView.loadImage(by: postImageURL)
        }
    }
    

}
