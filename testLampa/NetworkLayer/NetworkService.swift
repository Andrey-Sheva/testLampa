//
//  NetworkService.swift
//  testLampa
//
//  Created by Андрей Шевчук on 19.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import Foundation
import Moya

enum NetworkService{
    case popular(page: Int)
    case topRated(page: Int)
}
    
extension NetworkService: TargetType{
    
    var environmentBaseURL: String{
        switch NetworkManager.environment{
        case .staging:
            return "https://api.themoviedb.org/3/movie"
        case .qa:
            return "https://qa.themoviedb.org/3/movies"
        case .production:
            return "https://staging.themoviedb.org/3/movies"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {fatalError("base url couldnot configurate")}
        return url
    }
    
    var path: String {
        switch self{
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .popular:
            return .get
        case .topRated:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self{
        case .topRated(let page):
            return .requestParameters(parameters: ["page": page, "api_key" : NetworkManager.apiKey], encoding: URLEncoding.queryString)
        case .popular(let page):
            return .requestParameters(parameters: ["page": page,"api_key" : NetworkManager.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
