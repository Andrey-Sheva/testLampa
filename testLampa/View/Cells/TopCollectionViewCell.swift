//
//  TopCollectionViewCell.swift
//  testLampa
//
//  Created by Андрей Шевчук on 18.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit
import Kingfisher

class TopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    
    
    let nibName = "TopContentCollectionViewCell"
     let urlString = "https://image.tmdb.org/t/p/original"
    //
    var countOfPages = MainViewController.presenter.topRatedMovies?.count
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        configCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        configCollectionView()
        pageControl.numberOfPages = countOfPages ?? 20
        constraintsCollectionView()
        constraintsPageControll()
        pageControl.backgroundColor = .black
    }
    
    func configCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
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
        return MainViewController.presenter.topRatedMovies?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath) as! TopContentCollectionViewCell
        let topMovies = MainViewController.presenter.topRatedMovies?[indexPath.item]
        
        if let vote = topMovies?.voteAverage
        {
            cell.labelUrlDate.text = "Avarage vote: " + String(describing: vote)
        }
        if topMovies?.posterPath != nil {
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: urlString + topMovies!.posterPath),
                                   placeholder: nil,
                                   options: nil,
                                   progressBlock: nil,
                                   completionHandler: nil)
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
        cell.alpha = 0
           UIView.animate(withDuration: 1) {
            cell.alpha = 1
        }
    }
}

extension TopCollectionViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: 270)
    }
    
}
//MARK:- scroll pages one by one

class PageCollectionLayout: UICollectionViewFlowLayout {

    
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0

    public func setPreviousOffset(offset: CGFloat) {
        self.calculateCurrentPage(by: offset)
    }
    
    private func calculateCurrentPage(by offset: CGFloat) {
        let itemWidth: CGFloat = itemSize.width + minimumInteritemSpacing
        currentPage = Int(offset / itemWidth)
        let updatedOffset = (itemSize.width + minimumInteritemSpacing) * CGFloat(currentPage)
        previousOffset = updatedOffset
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }

        let itemsCount = collectionView.numberOfItems(inSection: 0)
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }
        let updatedOffset = (itemSize.width + minimumInteritemSpacing) * CGFloat(currentPage)
        previousOffset = updatedOffset
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
    }
}
