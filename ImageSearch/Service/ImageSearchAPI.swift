//
//  ImageSearchAPI.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import Foundation
import UIKit

class ImageSearchAPI: NSObject {
    
    static let shared = ImageSearchAPI()
    
    /**
     Gets the images from the server, with the user query.
     - Parameter userQuery: The query entered by the user in a search field.
     */
    func getImagesFromServer(with userQuery: String) async -> [String]? {
        
        let apiKey = Secret.API_KEY
        
        // Adds the '+' sign if the user enters a query with a whitespace
        let encodedUserQuery = userQuery.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        if let url = buildURL(with: encodedUserQuery, apiKey) {
                        
            do {
                let imageSearchResult = try await URLSession.shared.decode(ImageSearchResult.self, from: url)
                return imageSearchResult.hits.map { $0.largeImageURL }
            } catch {
                return nil
            }
        }
        
        return nil
    }
    
    /// Build the URL for the request.
    /// - Parameter userQuery: The formatted user query.
    /// - Parameter apiKey: The API Key to access the server.
    private func buildURL(with userQuery: String, _ apiKey: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pixabay.com"
        components.path = "/api/"
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: userQuery),
            URLQueryItem(name: "image_type", value: "photo")
        ]
        
        return components.url
    }
}
