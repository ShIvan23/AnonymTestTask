//
//  ModelsConverter.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import Foundation

final class ModelsConverter {
    
    // MARK: - Public Methods
    
    public func convertToPostModel(from model: PostForJSON) -> [Post] {
        let postModel = model.data.items.map {
            Post(postImage: $0.contents.first?.data.original?.url ?? "",
                 authorName: $0.author.name,
                 authorImage: $0.author.photo.data.small?.url ?? "",
                 likes: $0.stats.likes.count)
        }
        return postModel
    }
}
