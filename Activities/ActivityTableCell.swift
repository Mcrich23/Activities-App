//
//  ActivityTableCell.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import UIKit

class ActivityTableCell: UITableViewCell {
    let nameLabel = UILabel()
    let typeLabel = UILabel()
    let accessabilityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
     }
    
    func setActivity(for activity: Activity) {
        nameLabel.text = activity.name
        typeLabel.text = "Type: \(activity.type)"
        let accessabilityPercent = Int(abs(1-(activity.accessibility))*100)
        accessabilityLabel.text = "Accessability: \(accessabilityPercent)%"
    }
    
    func setup() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(accessabilityLabel)
        
        // Name constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        // Type constraints
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        
        // Accessablitiy constraints
        accessabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        accessabilityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        accessabilityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        accessabilityLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor).isActive = true
        accessabilityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setup()
    }
    
    func setupName() {
        nameLabel.text = ""
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 15)
    }
    
    func setupType() {
        typeLabel.text = ""
        typeLabel.numberOfLines = 0
        typeLabel.font = .systemFont(ofSize: 13)
    }
    
    func setupAccessability() {
        accessabilityLabel.text = ""
        accessabilityLabel.font = .systemFont(ofSize: 13)
    }
    
}
