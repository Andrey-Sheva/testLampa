//
//  MainBuilder.swift
//  testLampa
//
//  Created by Андрей Шевчук on 22.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

protocol Builder {
    func createMainModule() -> UIViewController
}

class MainBuilder: Builder{
    func createMainModule() -> UIViewController {
        let service = NetworkManager()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, service: service)
        MainViewController.presenter = presenter
        return view
    }
    
    
}
