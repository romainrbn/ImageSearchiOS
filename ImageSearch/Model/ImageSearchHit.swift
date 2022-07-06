//
//  ImageSearchHit.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import Foundation

/// A hit returned by the query, representing the data of an image
struct ImageSearchHit: Decodable {
    let id: Int
    let largeImageURL: String
}
