//
//  ViewController.swift
//  Tango
//
//  Created by sparecdmx on 10/9/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .green
        ServiceManager.shared.callService(url: "https://itunes.apple.com/search?term=rammstein&entity=album")
    }

}

