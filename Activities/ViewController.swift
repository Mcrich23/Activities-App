//
//  ViewController.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    var helloWorldLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        helloWorldLabel.text = "Hello World"
        self.title = "First View"
        view.backgroundColor = .white
        view.addSubview(helloWorldLabel)
        
        helloWorldLabel.translatesAutoresizingMaskIntoConstraints = false
        helloWorldLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloWorldLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}

