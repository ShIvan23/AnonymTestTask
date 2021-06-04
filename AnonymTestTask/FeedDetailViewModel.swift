//
//  FeedDetailViewModel.swift
//  AnonymTestTask
//
//  Created by Ivan on 03.06.2021.
//

import Foundation

protocol FeedDetailViewModelProtocol {
    init(post: Post)
    var authorName: String { get }
    var authorImage: URL? { get }
    var postImage: URL? { get }
    var likes: String { get }
}

final class FeedDetailViewModel: FeedDetailViewModelProtocol {
    
    // MARK: - Public Properties
    
    var authorName: String {
       "User name: \(post.authorName)"
    }
    
    var authorImage: URL? {
        guard let url = URL(string: post.authorImage) else { return nil }
        return url
    }
    
    var postImage: URL? {
        guard let url = URL(string: post.postImage) else { return nil }
        return url
    }
    
    var likes: String {
        "Likes: \(post.likes)"
    }
    
    // MARK: - Private Properties
    
    private let post: Post
    
    // MARK: - Initializers
    
    init(post: Post) {
        self.post = post
    }
}
