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
    var activities: [Activity] = []
    let backgroundView = UIView()
    let loading = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Activities"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.backgroundColor = .white
        
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
        activitiesTableView.register(LoadingTableCell.self, forCellReuseIdentifier: "loadingCell")
        activitiesTableView.isHidden = true
        
        // Loading Setup
        loading.hidesWhenStopped = true
        view.addSubview(loading)
        loading.startAnimating()
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        
        self.fetchActivities(count: 20)
    }
    
    func fetchActivities(count: Int) {
        Task {
            for _ in 0..<count {
                let activities = try await Activities.fetchActivity()
                self.activities.append(activities)
            }
            loading.stopAnimating()
            activitiesTableView.isHidden = false
            activitiesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= (self.activities.count-1) && !self.activities.isEmpty {
            let cell = ActivityTableCell(style: .default, reuseIdentifier: "activityCell", activity: activities[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingTableCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row <= (self.activities.count-1) && !self.activities.isEmpty {
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
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.activities.count) && !self.activities.isEmpty {
            let loadingCell = cell as! LoadingTableCell
            loadingCell.loading.startAnimating()
            self.fetchActivities(count: 5)
        }
    }
}

