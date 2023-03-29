//
//  ViewController.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let activitiesTableView = UITableView() // view
    var activities: [Activity] = [] {
        didSet {
            if activities.count >= 20 {
                loading.stopAnimating()
                activitiesTableView.reloadData()
            }
        }
    }
    let loading = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Activities"
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        view.backgroundColor = .white
        
        // Table Setup
        view.addSubview(activitiesTableView)
        activitiesTableView.translatesAutoresizingMaskIntoConstraints = false
        activitiesTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        activitiesTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        activitiesTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        activitiesTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        activitiesTableView.dataSource = self
        activitiesTableView.delegate = self
        activitiesTableView.register(ActivityTableCell.self, forCellReuseIdentifier: "activityCell")
        
        // Loading Setup
        loading.hidesWhenStopped = true
        view.addSubview(loading)
        loading.startAnimating()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        
        // Fetch Activities
        Task {
            for _ in 0..<20 {
                let activities = try await Activities.fetchActivity()
                self.activities.append(activities)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ActivityTableCell(style: .default, reuseIdentifier: "activityCell", activity: activities[indexPath.row])
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activity = activities[indexPath.row]
        if let url = URL(string: activity.url) {
            let safari = SFSafariViewController(url: url)
            self.present(safari, animated: true)
        } else {
            print("no url")
            let ok = UIAlertAction(title: "Ok", style: .default)
            
            let alert = UIAlertController(title: "Uh Oh", message: "There isn't a url for this activity", preferredStyle: .alert)
            alert.addAction(ok)
            
            self.present(alert, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

