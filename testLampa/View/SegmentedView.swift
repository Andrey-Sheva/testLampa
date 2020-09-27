//
//  SegmentedView.swift
//  testLampa
//
//  Created by Андрей Шевчук on 24.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class ViewSegmented: UIView{
    let view: UIView = {
         var mainView = UIView()
         mainView.backgroundColor = .white
         mainView.frame = CGRect(x: 0, y: 0, width: 380, height: 630)
         var label = UILabel()
         label.text = "NO INTERNET CONNECTION"
         label.numberOfLines = 0
         label.frame = CGRect(x: mainView.frame.width / 2 - 120, y: mainView.frame.height / 2, width: 250, height: 20)
         mainView.addSubview(label)
         return mainView
     }()
    convenience override init(frame: CGRect) {
        self.init(frame: frame)
    }
}
