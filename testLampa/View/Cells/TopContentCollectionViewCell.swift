//
//  TopContentCollectionViewCell.swift
//  testLampa
//
//  Created by Андрей Шевчук on 18.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class TopContentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var labelUrlDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageConstraints()
    }
    
    func setupImageConstraints(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
