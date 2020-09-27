//
//  MovieModel.swift
//  testLampa
//
//  Created by Андрей Шевчук on 19.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import Foundation

struct Movie {
    var posterPath: String
    var overview: String
    var voteAverage: Double
    var originalTitle: String
}
extension Movie: Decodable{
    enum ResultCodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case voteAverage = "vote_average"
        case originalTitle = "original_title"
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: ResultCodingKeys.self)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        overview = try container.decode(String.self, forKey: .overview)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
    }
}


struct MovieModel {
    var page: Int
    var results: [Movie]
}
extension MovieModel: Decodable{
    private enum MovieCodingKey: String, CodingKey{
        case page
        case results
    }
    init(rrom decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKey.self)
        page = try container.decode(Int.self, forKey: .page)
        results = try container.decode([Movie].self, forKey: .results)
    }
    
}
