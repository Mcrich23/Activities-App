//
//  ViewController.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var activitiesTableView: UITableView!
    var activities: [Activity] = []
    @IBOutlet weak var loading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Activities"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.activitiesTableView.isHidden = true
        self.activitiesTableView.delegate = self
        self.activitiesTableView.dataSource = self
        self.activitiesTableView.estimatedRowHeight = 60.0
        self.activitiesTableView.rowHeight = UITableView.automaticDimension
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableCell
            cell.setup(with: activities[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingTableCell
            return cell
        }
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
            self.fetchActivities(count: 5)
        }
    }
}

