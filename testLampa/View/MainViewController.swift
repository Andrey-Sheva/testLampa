//
//  ViewController.swift
//  testLampa
//
//  Created by Андрей Шевчук on 16.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    static var presenter: MainPresenter!

    var collectionView: UICollectionView!
    
    var segmented: CustomSegmentedControl!
    var isHidden: Bool!
    var searchBar = UISearchController()
    let searchController = SearchController()
    let topCellIdentifier = "cell"
    let topNibName = "TopCollectionViewCell"
    let defaultName = "DefaultCollectionViewCell"
    let urlString = "https://image.tmdb.org/t/p/original"
    let segmentedTitles = ["STORIES", "VIDEO", "FAVOURITES"]
    let image = UIImage(named: "menu")
    
    var moviesName = [String]()
    var filteredMovies = [String]()
    
  private let labelBarItem: UILabel = {
        var label = UILabel()
        label.text = "News"
        label.textColor = .white
        label.font = UIFont(name: "Thonburi-Bold", size: 20)
        label.textAlignment = .right
        return label
    }()
   private let topView: UIView = {
        var mainView = UIView()
        var image = UIImage(named: "top")
        var imageView = UIImageView(image: image)
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = .white
        imageView.frame = CGRect(x: 3, y: 4, width: 60, height: 20)
        mainView.addSubview(imageView)
        return mainView
    }()
    
   private let internetConnectionView: UIView = {
        var someView = UIView()
        someView.backgroundColor = .black
        var label = UILabel()
        label.textColor = .white
        label.text = "No Results"
        label.frame = CGRect(x: 20, y: 20, width: 100, height: 20)
        someView.addSubview(label)
        return someView
    }()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchBar.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchBar.isActive && !searchBarIsEmpty
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupView()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       get {
          return .portrait
       }
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
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(observSearch))
        let leftBarIButton = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        let title = UIBarButtonItem(customView: labelBarItem)
        
        navigationItem.searchController = nil
        
        searchBar = UISearchController(searchResultsController: searchController) //not working with ios 11
        searchController.delegate = self
        searchBar.searchBar.isHidden = true
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
        
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
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
        collectionView.addSubview(topView)
        createTopViewConstraints()
        
        //MARK:- config Nib cells
        let topNibCell = UINib(nibName: topNibName, bundle: nil)
        collectionView.register(topNibCell, forCellWithReuseIdentifier: topNibName)
        let defaultNib = UINib(nibName: defaultName, bundle: nil)
        collectionView.register(defaultNib, forCellWithReuseIdentifier: defaultName)
    }
    
    // MARK:- Setup collectionView constraints
    func setupCollectionViewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 62)
        ])
    }
    
    // MARK:- Setup ViewCintroller + customSegmentControl
      func setupView(){
          view.backgroundColor = .black
          let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height ?? 0.0)
        
        segmented = CustomSegmentedControl(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.width, height: topBarHeight), buttonTitles: segmentedTitles, view: internetConnectionView)
            internetConnectionView.frame = CGRect(x: 0, y: topBarHeight + 61, width: view.frame.width, height: view.frame.height)
            segmented.backgroundColor = .black
            view.addSubview(segmented)
        
          setupConstraints(segment: segmented)
          configCollectionView()
      }
    // MARK:- Setup segment constraints
    func setupConstraints(segment: CustomSegmentedControl){
        segment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segment.leftAnchor.constraint(equalTo: view.leftAnchor),
            segment.rightAnchor.constraint(equalTo: view.rightAnchor),
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segment.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func createTopViewConstraints(){
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: view.frame.width + 14),
            topView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 20),
            topView.heightAnchor.constraint(equalToConstant: 30),
            topView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    @objc func observSearch(){
         isHidden = searchBar.searchBar.isHidden
            if isHidden{
                DispatchQueue.main.async{
                    self.navigationItem.searchController = self.searchBar
                    self.searchBar.searchBar.isHidden = false
                    self.isHidden = false
                    self.navigationController?.view.setNeedsLayout()
                    self.navigationController?.view.layoutIfNeeded()
                }
            }else{
                DispatchQueue.main.async {
                    self.searchBar.searchBar.isHidden = true
                    self.navigationItem.searchController = nil
                    self.isHidden = true
                    self.navigationController?.view.setNeedsLayout()
                    self.navigationController?.view.layoutIfNeeded()
            }
        }
    }
}
//
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainViewController.presenter.movies?.count ?? 2
    }
    //MARK:- create cells and downloading content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = MainViewController.presenter.movies?[indexPath.item]
        //cell for vertical scroll
        if indexPath.item == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topNibName, for: indexPath) as! TopCollectionViewCell
        cell.backgroundColor = .clear
            DispatchQueue.main.async {
                cell.collectionView.reloadData()
            }
        return cell
            }
        else{
            //cell for list
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultName, for: indexPath) as! DefaultCollectionViewCell
            cell.textLabel.text = movie?.overview
            
            if let vote = movie?.voteAverage{
                cell.urlDateLabel.text = "Average vote: \(String(describing: vote))"
            }
            if movie?.posterPath != nil{
                cell.imageView.kf.indicatorType = .activity
                cell.imageView?.kf.setImage(with: URL(string: urlString + movie!.posterPath),
                                        placeholder: nil,
                                        options: nil,
                                        progressBlock: nil,
                                        completionHandler: nil)
            }
            cell.backgroundColor = .white
            return cell
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0{
            return CGSize(width: view.frame.width, height: 270)
        }else{
            return CGSize(width: view.frame.width, height: 400)
        }
    }
}


extension MainViewController: MainViewProtocol{
    func succes() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
// MARK:- search controller delegate
extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String){
        let arr = MainViewController.presenter.getAllMovies()

        for originalName in arr{
            moviesName.append(originalName.originalTitle)
        }
        filteredMovies = moviesName.filter({ (movieName) -> Bool in
            return movieName.lowercased().contains(searchText.lowercased())
        })
        SearchController.tableView.reloadData()
    }
}

extension MainViewController: Delegate{
    func updateCell(cell: UITableViewCell, indexPath: Int) {
        if isFiltering{
            if filteredMovies.isEmpty{
                 cell.textLabel?.text = "no results"
            }else{
                 cell.textLabel?.text = "\(filteredMovies[0])"
            }
            
        }else{
            cell.textLabel?.text = "\(moviesName[indexPath])"
        }
    }
}
