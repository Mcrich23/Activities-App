//
//  ActivityTableCell.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import UIKit

class ActivityTableCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var accessebility: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     }
    
    func setup(with activity: Activity) {
        name.text = activity.name
        type.text = "Type: \(activity.type)"
        let accessablityPercentage = Int(abs(1-(activity.accessibility))*100)
        accessebility.text = "Accessability: \(accessablityPercentage)%"
    }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}
