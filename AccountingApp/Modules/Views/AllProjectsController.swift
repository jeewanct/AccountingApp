//
//  AllProjectsController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class AllProjectsController: UICollectionViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        navigationItem.title = "Projects"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    
    var presenter: ViewToPresenterProtocol?
}

extension AllProjectsController: UICollectionViewDelegateFlowLayout{
    
    
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "ProjectDetailsCell", bundle: nil), forCellWithReuseIdentifier: "ProjectDetailsCell")
    
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectDetailsCell", for: indexPath) as! ProjectDetailsCell
        return cell
    }
}


extension AllProjectsController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
}
