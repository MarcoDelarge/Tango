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
            ServiceManager.shared.callService(url: "https://itunes.apple.com/search?term=" + artist + "&entity=album") { [weak self] in
                self?.albumNames = $0
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

