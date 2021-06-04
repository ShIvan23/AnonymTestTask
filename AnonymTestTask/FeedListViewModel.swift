//
//  FeedListViewModel.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import Foundation

protocol FeedListViewModelProtocol {
    var postsArray: [Post] { get }
    func fetchPosts(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> FeedListCellViewModelProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> FeedDetailViewModelProtocol
    func setFilterState(to filterState: FilterState)
    var filterStateDidChanged: (() -> Void)? { get set }
}

final class FeedListViewModel: FeedListViewModelProtocol {
    
    // MARK: - Public Properties
    
    private(set) var postsArray = [Post]()
    
    var filterStateDidChanged: (() -> Void)?
    
    // MARK: - Private Properties
    
    private let modelsConverter = ModelsConverter()
    private let anonymManager = AnonymManager()
    
    private var filterState: FilterState?
    
    // MARK: - Public Methods
    
    func fetchPosts(completion: @escaping () -> Void) {
        anonymManager.fetchPosts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                self.anonymManager.requestService.cursor = posts.data.cursor
                let currentModel = self.modelsConverter.convertToPostModel(from: posts)
                self.postsArray.append(contentsOf: currentModel)
                completion()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        postsArray.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> FeedListCellViewModelProtocol {
        let post = postsArray[indexPath.row]
        return FeedListCellViewModel(post: post)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> FeedDetailViewModelProtocol {
        let post = postsArray[indexPath.row]
        return FeedDetailViewModel(post: post)
    }
    
    func setFilterState(to filterState: FilterState) {
        self.filterState = filterState
        fetchPostsWithFilter()
    }
    
    // MARK: - Private Methods
    
    private func fetchPostsWithFilter() {
        anonymManager.fetchPostsWithFilter(filterState!.rawValue) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                let currentModel = self.modelsConverter.convertToPostModel(from: posts)
                self.postsArray.removeAll()
                self.postsArray = currentModel
                self.filterStateDidChanged?()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
