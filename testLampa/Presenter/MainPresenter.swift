//
//  MainPresenter.swift
//  testLampa
//
//  Created by Андрей Шевчук on 22.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import Foundation
protocol MainViewProtocol: class{
    func succes()
    func failure(error: Error)
}
protocol MainViewPresenterProtocol{
    init(view: MainViewProtocol, service: NetworkManager)
    var movies: [Movie]? {get set}
}


class MainPresenter: MainViewPresenterProtocol{
   
    var movies: [Movie]?
    var topRatedMovies: [Movie]?
    
    weak var view: MainViewProtocol?
    let service: NetworkManager!
    
       required init(view: MainViewProtocol, service: NetworkManager) {
        self.view = view
        self.service = service
        updatePopularsMovies()
        updateTopRated()
       }
    func updatePopularsMovies(){
        service.getPopular(page: 1) {[weak self] (movies) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.movies = movies
                self.view?.succes()
            }
        }
    }
    func updateTopRated(){
        service.getTopMovies(page: 1) { [weak self] (movies) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.topRatedMovies = movies
                self.view?.succes()
            }
        }
    }
    func getAllMovies() -> [Movie]{
        guard let movies = movies, let topRatedMovies = topRatedMovies else {return []}
        let arr = movies
        return arr
    }
}
