//
//  FeedDetailView.swift
//  AnonymTestTask
//
//  Created by Ivan on 03.06.2021.
//

import UIKit

final class FeedDetailView: UIView {

   // MARK: - Public Properties
    
    public let authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "defaultAvatar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "noImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public let likesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: CGRect())
        customizeView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func customizeView() {
        backgroundColor = .white
    }
    
    private func setConstraints() {
        
        [authorImageView, authorNameLabel, postImageView, likesLabel].forEach { addSubview($0) }
        
        let inset: CGFloat = 30
        let authorImageSize: CGFloat = 80
        
        NSLayoutConstraint.activate([
            authorImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset),
            authorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            authorImageView.heightAnchor.constraint(equalToConstant: authorImageSize),
            authorImageView.widthAnchor.constraint(equalToConstant: authorImageSize),
            
            authorNameLabel.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: inset),
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            
            postImageView.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: inset),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            postImageView.heightAnchor.constraint(equalToConstant: 250),
            
            likesLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: inset),
            likesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            likesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset)
        ])
    }
    
}
