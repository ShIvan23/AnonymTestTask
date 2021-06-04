//
//  FeedListCell.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import UIKit

class FeedListCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public var viewModel: FeedListCellViewModelProtocol! {
        didSet {
            setupCell()
        }
    }
    
    // MARK: - Private Properties
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        authorImageView.layer.cornerRadius = authorImageView.frame.height / 2
    }
    
    // MARK: - Private Methods
    
    private func setupCell() {
        clearCellForReuse()
        authorNameLabel.text = viewModel.authorName
        likesLabel.text = viewModel.likes
        if let authorImageURL = viewModel.authorImage {
            authorImageView.loadImage(by: authorImageURL)
        }
        if let postImageURL = viewModel.postImage {
            postImageView.loadImage(by: postImageURL)
        }
    }
    
    private func clearCellForReuse() {
        authorNameLabel.text = ""
        likesLabel.text = ""
        authorImageView.image = UIImage(named: "defaultAvatar")
        postImageView.image = UIImage(named: "noImage")
    }
    
    private func setConstraints() {
        
        addSubview(authorNameLabel)
        addSubview(authorImageView)
        addSubview(postImageView)
        addSubview(likesLabel)
        
        let inset: CGFloat = 15
        
        NSLayoutConstraint.activate([
            authorImageView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            authorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            authorImageView.heightAnchor.constraint(equalToConstant: 40),
            authorImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            authorNameLabel.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: inset),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: inset),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            postImageView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            likesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            likesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            likesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset)
        ])
    }
    
}
