//
//  Post.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import Foundation

struct Post: Decodable {
   let data: DataPosts
    
    struct DataPosts: Decodable {
        let items: [Items]
        let cursor: String
    }
    
    struct Items: Decodable {
        let contents: [Contents]
        let author: Author
        let stats: Stats
        
        struct Contents: Decodable {
            let data: DataImagePost
            
            struct DataImagePost: Decodable {
                let medium: Medium?
                
                struct Medium: Decodable {
                    let url: String
                }
            }
        }
        
        struct Author: Decodable {
            let name: String
            let photo: Photo
            
            struct Photo: Decodable {
                let data: DataImageAuthor
                
                struct DataImageAuthor: Decodable {
                    let small: Small?
                    
                    struct Small: Decodable {
                        let url: String
                    }
                }
            }
        }
        
        struct Stats: Decodable {
            let likes: Likes
            
            struct Likes: Decodable {
                let count: Int
            }
        }
    }
}
