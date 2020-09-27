//
//  DefaultCollectionViewCell.swift
//  testLampa
//
//  Created by Андрей Шевчук on 18.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class DefaultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageConstraints()
        setupTextConstraints()
        setupurlTextConstraints()
        configUI()
    }
    
    func configUI(){
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = .clear
        textLabel.font = UIFont(name: "Thonburi", size: 13)
        
        urlDateLabel.font = UIFont(name: "Thonburi-Bold", size: 13)
        urlDateLabel.backgroundColor = .clear
        
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
    }
    
    func setupImageConstraints(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,constant: 20),
            imageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height - (contentView.frame.height / 8))
        ])
    }
    func setupTextConstraints(){
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        textLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
        textLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
        textLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -20),
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor)
    ])
    }
    
    func setupurlTextConstraints(){
        urlDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        urlDateLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
        urlDateLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
        urlDateLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -2),
        urlDateLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor)
    ])
    }
}
