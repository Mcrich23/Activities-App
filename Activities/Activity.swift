//
//  Activity.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import Foundation

class Activity: Codable {
    var name: String
    var accessibility: Double
    var type: String
    var participants: Int
    var price: Double
    var url: String
    var key: String
    
    init(name: String, accessibility: Double, type: String, participants: Int, price: Double, url: String, key: String) {
        self.name = name
        self.accessibility = accessibility
        self.type = type
        self.participants = participants
        self.price = price
        self.url = url
        self.key = key
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "activity"
        case accessibility
        case type
        case participants
        case price
        case url = "link"
        case key
    }
    
    static let blank = Activity(name: "name", accessibility: 0, type: "type", participants: 0, price: 0, url: "https://mcrich23.com", key: "key")
}
