//
//  FeedListCellViewModel.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import Foundation

protocol FeedListCellViewModelProtocol {
    init(post: Post)
    var authorName: String { get }
    var authorImage: URL? { get }
    var postImage: URL? { get }
    var likes: String { get }
}

final class FeedListCellViewModel: FeedListCellViewModelProtocol {
    
    // MARK: - Public Properties
    
    var authorName: String {
        post.authorName
    }
    
    var authorImage: URL? {
        guard let url = URL(string: post.authorImage) else { return nil}
        return url
//        post.authorImage
    }
    
    var postImage: URL? {
        guard let url = URL(string: post.postImage) else { return nil }
        return url
//        post.postImage
    }
    
    var likes: String {
        "Likes: \(post.likes)"
    }
    
    // MARK: - Private properties
    
    private let post: Post
    
    // MARK: - Initializers
    
    init(post: Post) {
        self.post = post
    }
}
