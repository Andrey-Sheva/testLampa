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
    @IBOutlet weak var labelUrlDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configViews()
        setupImageConstraints()
        setupLabelConstraints()
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
    
    func setupLabelConstraints(){
    labelUrlDate.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        labelUrlDate.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 3),
        labelUrlDate.widthAnchor.constraint(equalToConstant: contentView.frame.width/4.3),
        labelUrlDate.heightAnchor.constraint(equalToConstant: 30),
        labelUrlDate.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -20)
    ])
    }

    //MARK:- confug Labels
    func configViews(){
        labelUrlDate.backgroundColor = .black
        labelUrlDate.alpha = 0.6
        labelUrlDate.layer.cornerRadius = 20
        labelUrlDate.textColor = .white
        labelUrlDate.font = UIFont(name:"Thonburi-Bold" , size: 11)
        labelUrlDate.textAlignment = .left
        
        
        imageView.contentMode = .scaleToFill
    }
}
