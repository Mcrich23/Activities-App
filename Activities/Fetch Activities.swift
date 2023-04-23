//
//  Fetch Activities.swift
//  Activities
//
//  Created by Morris Richman on 3/29/23.
//

import Foundation

class Activities {
    static func fetchActivity() async throws -> Activity {
        let url = URL(string: "https://www.boredapi.com/api/activity")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let activity = try jsonDecoder.decode(Activity.self, from: data)
        return activity
    }
}
