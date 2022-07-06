//
//  ImageSearchResult.swift
//  ImageSearch
//
//  Created by Romain RABOUAN on 06/07/2022.
//

import Foundation

/// The dictionary returned by the search query, containing all the hit results
struct ImageSearchResult: Decodable {
    let totalHits: Int
    
    let hits: [ImageSearchHit]
}
