//
//  SearchVC.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import UIKit
import SVProgressHUD
import Lottie
protocol SearchVCDelegate {
    func onLastSearch(book: [BookItem])
}

class SearchVC: UIViewController {
    private var searchVM = SearchViewModel()
    @IBOutlet weak var srcBar: UISearchBar!
    @IBOutlet weak var srcTbl: UICollectionView!
    var delegate: SearchVCDelegate?
    var isFromPopular = false
    var searchKeyword = ""
    private var animationView = AnimationView()
    private var listIsAvailable = false {
        didSet {
            if listIsAvailable {
                animationView.stop()
                animationView.isHidden = true
                animationContainer.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var animationContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        srcTbl.register(UINib(nibName: SearchCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        srcTbl.dataSource = self
        srcTbl.delegate = self
        setupSearchBar()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        hideKeyboardWhenTappedAround()
        
        if isFromPopular {
            doSearchBook()
            srcBar.text = searchKeyword
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.srcBar.becomeFirstResponder()
            }
        }
        setupAnimation()
    }
    
    private func setupAnimation(isLoading: Bool = false) {
        var animationName = "anim_dino"
        if isLoading {
            animationName = "anim_loading"
        }
        
        animationView.animation = Animation.named(animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.clipsToBounds = true
        animationView.loopMode = LottieLoopMode.loop
        //        animationView.animationSpeed =
        animationContainer.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.leftAnchor.constraint(equalTo: animationContainer.leftAnchor).isActive = true
        animationView.rightAnchor.constraint(equalTo: animationContainer.rightAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: animationContainer.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: animationContainer.bottomAnchor).isActive = true
        animationView.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.onLastSearch(book: searchVM.bookList) 
        self.dismissKeyboard()
    }
    
    private func setupSearchBar() {
        srcBar.delegate = self
        srcBar.layer.borderWidth = 1
        srcBar.layer.borderColor = self.navigationController?.navigationBar.barTintColor?.cgColor
    }

    
    private func doSearchBook(isFromPopular: Bool = false) {
        if searchVM.bookList.isEmpty {
            setupAnimation(isLoading: true)
        } else {
            SVProgressHUD.show()
        }
        searchVM.searchBook(keyword: searchKeyword) { (result) in
            SVProgressHUD.dismiss()
            switch result {
            case .success(_ ) :
                self.srcTbl.reloadData()
                self.dismissKeyboard()
            case .failure(let error) :
                print(error.localizedDescription)
            }
            
            if !self.searchVM.bookList.isEmpty {
                self.listIsAvailable = true
            } else {
                self.listIsAvailable = false
            }
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        self.dismissKeyboard()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchKeyword = searchBar.text ?? ""
            doSearchBook()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension SearchVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchVM.bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bookItem = searchVM.bookList[indexPath.row]
        
        return cell
    }
    
    
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 3
        let collectionViewWidth = collectionView.frame.size.width - padding
        let collectionViewHeight = collectionView.frame.height
        return CGSize(width: collectionViewWidth/2.2, height: collectionViewHeight/2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
