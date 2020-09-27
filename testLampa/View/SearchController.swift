//
//  SearchController.swift
//  testLampa
//
//  Created by Андрей Шевчук on 24.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class SearchController: UIViewController{
    weak var delegate: Delegate?
    
    var searchFilms = [String]()
    static let tableView = UITableView()
    let topBarHeight = UIApplication.shared.statusBarFrame.size.height + 60
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
        view.addSubview(SearchController.tableView)
        constraints()
        SearchController.tableView.delegate = self
        SearchController.tableView.dataSource = self
        SearchController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func constraints(){
        SearchController.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            SearchController.tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            SearchController.tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            SearchController.tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBarHeight),
            SearchController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension SearchController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.presenter.getAllMovies().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        delegate?.updateCell(cell: cell, indexPath: indexPath.row)
        return cell
    }
}
