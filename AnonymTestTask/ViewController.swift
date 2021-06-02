//
//  ViewController.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import UIKit

class ViewController: UIViewController {

    let anonymManager = AnonymManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        anonymManager.fetchPosts { result in
            switch result {
            case .success(let posts):
                print(posts)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

