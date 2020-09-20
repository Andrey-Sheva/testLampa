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
    @IBOutlet var collectionView: UICollectionView!
    
    let nibName = "TopContentCollectionViewCell"
    
    
    var fff = [1,4,2,2]
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        configCollectionView()
        pageControl.numberOfPages = fff.count
        constraintsCollectionView()
        constraintsPageControll()
        pageControl.backgroundColor = .black
    }
    
    
    
    func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        
        let topRatedNib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(topRatedNib, forCellWithReuseIdentifier: nibName)
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
extension TopCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath)
        return cell
    }
   
}
extension TopCollectionViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: 270)
    }
}
