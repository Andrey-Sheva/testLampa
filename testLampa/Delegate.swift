//
//  Delegate.swift
//  testLampa
//
//  Created by Андрей Шевчук on 25.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

protocol Delegate: class {
    func updateCell(cell: UITableViewCell, indexPath: Int)
}
