//
//  NetworkManager.swift
//  testLampa
//
//  Created by Андрей Шевчук on 20.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import Foundation
import Moya

struct AuthPlugin: PluginType {
  let token: String

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    print("prepare")
    var request = request
    request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    return request
  }
}

protocol Networkable{
    var provider: MoyaProvider<NetworkService> {get}
    func getTopMovies(page: Int, completion: @escaping ([Movie]) -> ())
    func getPopular(page: Int, completion: @escaping ([Movie]) -> ())
}
enum APIEnvironment{
    case staging
    case qa
    case production
}

class NetworkManager: Networkable{
    
    static let apiKey = "eb16577b7e1fc32fe3b90712867d40ed"
    
    var provider = MoyaProvider<NetworkService>(plugins: [AuthPlugin(token: "eb16577b7e1fc32fe3b90712867d40ed"), NetworkLoggerPlugin(verbose: true)])
    static let environment: APIEnvironment = .staging
    
    func getTopMovies(page: Int, completion: @escaping ([Movie]) ->()) {
        provider.request(.topRated(page: page)) { (result) in
            switch result{
            case let .success(response):
                do{
                    let results = try JSONDecoder().decode(MovieModel.self, from: response.data)
                    completion(results.results)
                }catch let err{
                    print("error")
                    print(err)
                }
            case let .failure(error):
                print("error")
                print(error)
            }
        }
    }
    func getPopular(page: Int, completion: @escaping ([Movie]) -> ()) {
        provider.request(.popular(page: page)) { (result) in
            switch result{
            case let .success(response):
                do{
                    let results = try JSONDecoder().decode(MovieModel.self, from: response.data)
                    completion(results.results)
                }catch let err{
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
