//
//  LoadingTableCell.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import UIKit

class LoadingTableCell: UITableViewCell {
    let loading = UIActivityIndicatorView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
