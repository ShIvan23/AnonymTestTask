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
            viewModel.filterStateDidChanged = { [weak self] in
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
    
    private let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(frame: CGRect(x: 0, y: 0, width: 500, height: 50))
        segmentControl.insertSegment(withTitle: "Most Popular", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Most Commented", at: 1, animated: true)
        segmentControl.insertSegment(withTitle: "Created At", at: 2, animated: true)
        return segmentControl
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        setConstraints()
        setViewModel()
        setupNavigationController()
        setupSegmentControl()
    }
    
    // MARK: - Public Methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == feedTableView,
              (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height else { return }

        viewModel.fetchPosts { [weak self] in
            guard let self = self else { return }
            self.feedTableView.reloadData()
        }
    }
    
    // MARK: - Private Methods
    
    @objc private func segmentControlDidTaped() {
        switch segmentControl.selectedSegmentIndex {
        case 0: viewModel.setFilterState(to: .mostPopular)
        case 1: viewModel.setFilterState(to: .mostCommented)
        case 2: viewModel.setFilterState(to: .createdAt)
        default: return
        }
    }
    
    private func setViewModel() {
        viewModel = FeedListViewModel()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.topItem?.titleView = segmentControl
        navigationController?.navigationBar.barTintColor = .white
    }
    
    private func setupSegmentControl() {
        segmentControl.addTarget(self, action: #selector(segmentControlDidTaped), for: .valueChanged)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewModel = viewModel.viewModelForSelectedRow(at: indexPath)
        let detailVC = FeedDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
