//
//  RequestService.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import Foundation

protocol RequestServiceProtocol {
    var cursor: String? { get }
    func postsRequest(cursor: String?) -> URLRequest?
}

final class RequestService: RequestServiceProtocol {
    
    // MARK: - Public Properties
    
   var cursor: String?
    
    // MARK: - Public Methods
    
    func postsRequest(cursor: String?) -> URLRequest? {
        
        let baseURL = "https://k8s-stage.apianon.ru/posts/v1/posts"
        guard let cursor = cursor,
              let url = URL(string: "\(baseURL)?after=\(cursor)") else {
            
            guard let url = URL(string: "\(baseURL)?first=20") else { return nil }
            return URLRequest(url: url)
        }
        
        return URLRequest(url: url)
    }
}
