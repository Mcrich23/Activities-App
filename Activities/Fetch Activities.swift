//
//  Fetch Activities.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import Foundation

struct Activities {
    static func fetchActivity() async throws -> Activity {
        guard let url = URL(string: "https://www.boredapi.com/api/activity") else { return .blank }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return .blank }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let activity = try jsonDecoder.decode(Activity.self, from: data)
        return activity
    }
}
