//
//  TopCollectionViewCell.swift
//  testLampa
//
//  Created by Андрей Шевчук on 18.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    
    var fff = [1,4,2,2]
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        pageControl.numberOfPages = fff.count
        constraintsCollectionView()
        constraintsPageControll()
        pageControl.backgroundColor = .black
    }
    
    func configCollectionView(){
        let topRatedNib = UINib(nibName: "TopContentCollectionViewCell", bundle: nil)
        collectionView.register(topRatedNib, forCellWithReuseIdentifier: "cell")
    }
    func constraintsCollectionView(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
}
    func constraintsPageControll(){
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            pageControl.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            pageControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
