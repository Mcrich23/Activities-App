//
//  ActivityTableCell.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import UIKit

class ActivityTableCell: UITableViewCell {
    let activity: Activity
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.activity = Activity.blank
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
     }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, activity: Activity) {
        self.activity = activity
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
     }
    
    func setup() {
        let name = setupName()
        let type = setupType()
        let accessability = setupAccessablitity()
        contentView.addSubview(name)
        contentView.addSubview(type)
        contentView.addSubview(accessability)
        
        // Name constraints
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        name.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        // Type constraints
        type.translatesAutoresizingMaskIntoConstraints = false
        type.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        type.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        type.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        
        // Accessablitiy constraints
        accessability.translatesAutoresizingMaskIntoConstraints = false
        accessability.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        accessability.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        accessability.topAnchor.constraint(equalTo: type.bottomAnchor).isActive = true
        accessability.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

     required init?(coder aDecoder: NSCoder) {
         self.activity = Activity.blank
       super.init(coder: aDecoder)
    }
    
    func setupName() -> UILabel {
        let label = UILabel()
        label.text = activity.name
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }
    
    func setupType() -> UILabel {
        let label = UILabel()
        label.text = "Type: \(activity.type)"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13)
        return label
    }
    
    func setupAccessablitity() -> UILabel {
        let accessablity = Int(abs(0-(activity.accessibility*100)))
        let label = UILabel()
        label.text = "Accessability: \(accessablity)%"
        label.font = .systemFont(ofSize: 13)
        return label
    }
    
}
