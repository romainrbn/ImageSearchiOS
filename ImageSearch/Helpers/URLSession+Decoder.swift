//
//  URLSession+Decoder.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import Foundation

extension URLSession {
    /// A simple extension allowing us to decode JSON into a Codable structure more easily
    /// - Parameter type: The type of data to decode
    /// - Parameter url: The URL to decode the data from.
    func decode<T: Decodable>(_ type: T.Type = T.self, from url: URL) async throws -> T {
        let (data, _) = try await data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        decoder.dataDecodingStrategy = .deferredToData
        decoder.dateDecodingStrategy = .deferredToDate
        
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}
