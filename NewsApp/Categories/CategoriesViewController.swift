//
//  CategoriesViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 18.09.2023.
//

import UIKit
import Kingfisher

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = CategoriesViewModel()
    var categoryNewsList: [Article] = []
    var sideMenu: MenuItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionViewSet()
        prepareNavigationBar()
        configureNavBarWithLogoImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.fetchCategoryNews(categoryName: sideMenu?.categoryName ?? "business")
    }
    
    func collectionViewSet() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func prepareNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = sideMenu?.name ?? "Business"
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryNewsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.titleLabel.text = categoryNewsList[indexPath.row].title
        cell.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        cell.layer.cornerRadius = 10
        cell.sourceLabel.text = categoryNewsList[indexPath.row].source?.name
        cell.publishTimeLabel.text = Utilities.publishDateFormat(publishedAt: categoryNewsList[indexPath.row].publishedAt)
        cell.categoryImageView.kf.setImage(with: URL(string: categoryNewsList[indexPath.row].urlToImage ?? Utilities.emptyURL))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.newsResponseModel = categoryNewsList[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CategoriesViewController: CategoriesViewModelDelegate {
    func categoryNewsFetched(_ articles: [Article]) {
        categoryNewsList = articles
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    //    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: (collectionView.bounds.size.width - 40) / 2, height: 300)
    //    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
