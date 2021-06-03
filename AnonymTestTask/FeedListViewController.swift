//
//  FeedListViewController.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import UIKit

class FeedListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: FeedListViewModelProtocol! {
        didSet {
            viewModel.fetchPosts { [weak self] in
                guard let self = self else { return }
                self.feedTableView.reloadData()
            }
        }
    }
    
    private lazy var feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cell: FeedListCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeView()
        setConstraints()
        setViewModel()
    }
    
    // MARK: - Private Methods
    
    private func setViewModel() {
        viewModel = FeedListViewModel()
    }
    
    private func customizeView() {
        view.backgroundColor = .white
        title = "Feed"
    }
    
    private func setConstraints() {
        view.addSubview(feedTableView)
        
        NSLayoutConstraint.activate([
            feedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            feedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

// MARK: - UITable View Data Source

extension FeedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedListCell = tableView.dequeueCell(for: indexPath)
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
}

// MARK: - UITable View Delegate

extension FeedListViewController: UITableViewDelegate {
    
}
