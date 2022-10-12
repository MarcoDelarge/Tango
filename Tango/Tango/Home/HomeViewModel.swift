//
//  HomeViewModel.swift
//  Tango
//
//  Created by sparecdmx on 10/10/22.
//

import Foundation

protocol HomeViewModelProtocol {
    var reloadData: () -> Void { get set }
    var albumNames: [String] { get set }
    func goToDetail() -> Void
    func search(artist: String) -> Void
}

final class HomeViewModel: HomeViewModelProtocol {
    
    var router: HomeRouterProtocol?

    var albumNames: [String] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        }
    }

    private var searchTask: DispatchWorkItem?
    
    var reloadData: () -> Void = {}
    
    func search(artist: String) {
        self.searchTask?.cancel()
        let task = DispatchWorkItem {
            ServiceManager.request(endpoint: ItunesEndpoint.getSearchResults(searchText: artist)) { [weak self] (result: Result<FullResponse, Error>) in
                switch result {
                case .success(let response):
                    self?.albumNames = response.results.map{ $0.album ?? "" }
                case .failure(let error):
                    print(error)
                }
            }
        }
        self.searchTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
    }

    func goToDetail() {
        if let router {
            router.goToDetail()
        }
    }
}

