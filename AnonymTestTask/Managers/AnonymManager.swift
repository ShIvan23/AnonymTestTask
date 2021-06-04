//
//  AnonymManager.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import Foundation

typealias PostsResult = (Result<PostForJSON, Error>) -> Void

final class AnonymManager {
    
    // MARK: - Public Properties
    
    public let requestService = RequestService()
    
    // MARK: - Private Properties
    
    private let dataTaskService = DataTaskService()
    
    // MARK: - Public Methods
    
    public func fetchPosts(completion: @escaping PostsResult) {
        
        guard let request = requestService.postsRequest(cursor: requestService.cursor) else { return }
        dataTaskService.fetch(request: request, completionHandler: completion)
    }
    
    public func fetchPostsWithFilter(_ string: String, completion: @escaping PostsResult) {
        
        guard let request = requestService.postsRequestWithFilter(string) else { return }
        dataTaskService.fetch(request: request, completionHandler: completion)
    }
}
