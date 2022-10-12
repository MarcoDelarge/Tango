//
//  HomeRouter.swift
//  Tango
//
//  Created by sparecdmx on 10/10/22.
//

import Foundation
import UIKit

protocol HomeRouterProtocol {
    func goToDetail() -> Void
}

final class HomeRouter: HomeRouterProtocol {
    var view: HomeViewController = HomeViewController()
    var viewModel: HomeViewModel = HomeViewModel()
    var navigationController: UINavigationController = UINavigationController()

    func present() -> UINavigationController {
        view.viewModel = viewModel
        viewModel.router = self
        navigationController.setViewControllers([view], animated: false)
        return navigationController
    }
    
    func goToDetail() {
        DetailRouter.presentModal(into: self.view)
    }
}

final class DetailRouter {

    private static var view: UIViewController = ViewController()
    private static var navigationController: UINavigationController = UINavigationController()
    
    static func presentModal(into: UIViewController) {
        into.present(view, animated: true)
    }
    
    func showImage() {
        
    }

    func goToHome() {
        
    }
    
}
