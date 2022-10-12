//
//  HomeViewController.swift
//  Tango
//
//  Created by sparecdmx on 10/10/22.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {

    var viewModel: HomeViewModelProtocol?
    var albums: [String] = []
    
    lazy var mainTable: UITableView = {
        var table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    lazy var searchBar: UISearchController = {
        var search: UISearchController = UISearchController()
        search.searchBar.translatesAutoresizingMaskIntoConstraints = false
        search.searchBar.placeholder = "Band"
        search.searchBar.delegate = self
        return search
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Title"
        self.view.addSubview(mainTable)
        mainTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationItem.searchController = searchBar
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.reloadData = mainTable.reloadData
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel {
            return viewModel.albumNames.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let viewModel, !viewModel.albumNames.isEmpty {
            var content = cell.defaultContentConfiguration()
            content.text = viewModel.albumNames[indexPath.row]
            cell.contentConfiguration = content
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel {
            viewModel.goToDetail()
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let viewModel {
            viewModel.search(artist: searchText)
        }
    }
}
