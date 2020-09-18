//
//  ViewController.swift
//  testLampa
//
//  Created by Андрей Шевчук on 16.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    let segmentedTitles = ["STORIES", "VIDEO", "FAVOURITES"]
    let image = UIImage(named: "menu")
    let labelBarItem: UILabel = {
        var label = UILabel()
        label.text = "News"
        label.textColor = .white
        label.font = UIFont(name: "Thonburi-Bold", size: 20)
        label.textAlignment = .right
        return label
    }()
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    
    }
    
  
    // MARK:- Config navigationBar
    func configNavigationBar(){
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        let leftBarIButton = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        let title = UIBarButtonItem(customView: labelBarItem)
        
        navigationController?.navigationBar.barTintColor = .black
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        navigationItem.leftBarButtonItems = [leftBarIButton, title]
        navigationItem.leftBarButtonItem?.tintColor = .white
        
    }
    
    // MARK:- Config collectionView
    func configCollectionView(){
        let collectionLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
        
    }
    
    // MARK:- Setup collectionView constraints
    func setupCollectionViewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    // MARK:- Setup ViewCintroller + customSegmentControl
      func setupView(){
          view.backgroundColor = .black
          let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height ?? 0.0)
          let segmented = CustomSegmentedControl(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.width, height: topBarHeight), buttonTitles: segmentedTitles)
          segmented.backgroundColor = .black
          view.addSubview(segmented)
          setupConstraints(segment: segmented)
        //  configCollectionView()
          
      }
    // MARK:- Setup segment constraints
    func setupConstraints(segment: CustomSegmentedControl){
        segment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segment.leftAnchor.constraint(equalTo: view.leftAnchor),
            segment.rightAnchor.constraint(equalTo: view.rightAnchor),
            segment.topAnchor.constraint(equalTo: view.topAnchor),
            segment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
//
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
//
}
extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: view.frame.width)
    }
}






