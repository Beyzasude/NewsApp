//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 10.09.2023.
//

import UIKit
import Kingfisher
import SideMenu
import JGProgressHUD

class HomeViewController: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var topHeadCollectionView: UICollectionView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var lastestCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var todayDateLabel: UILabel!
    
    var menu: SideMenuNavigationController?
    var viewModel = HomeViewModel()
    
    var topHeadList: [Article] = []
    var trendNewsList: [Article] = []
    var lastestList: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.show(in: view)
        viewModel.delegate = self
        configureNavBarWithLogoImage()
        collectionViewsSet()
        Utilities.todayDate(todayDateLabel: todayDateLabel)
        pageControl.currentPage = 0
        
        menu = SideMenuNavigationController(rootViewController: MenuListTableViewController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        spinner.dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.fetchTrendNews()
        viewModel.fetchTopHeadlines()
        viewModel.fetchLastestNews()
        
    }
    
    func collectionViewsSet() {
        topHeadCollectionView.dataSource = self
        topHeadCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        lastestCollectionView.delegate = self
        lastestCollectionView.dataSource = self
    }
    
    @IBAction func sideMenuButtonAct(_ sender: Any) {
        present(menu!, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topHeadCollectionView {
            return topHeadList.count
        }else if collectionView == trendingCollectionView {
            return trendNewsList.count
        }else {
            return lastestList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topHeadCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topHeadNewsCell", for: indexPath) as! TopHeadNewsCollectionViewCell
            cell.imageView.kf.setImage(with: URL(string: topHeadList[indexPath.row].urlToImage ?? Utilities.emptyURL))
            cell.titleLabel.text = topHeadList[indexPath.row].title
            cell.imageView.layer.cornerRadius = 12
            cell.layer.borderColor = UIColor.secondarySystemBackground.cgColor
            cell.layer.cornerRadius = 10
            return cell
        }else if collectionView == trendingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trengingNewsCell", for: indexPath) as! TrendingNewsCollectionViewCell
            cell.titleLabel.text = trendNewsList[indexPath.row].title
            cell.sourceLabel.text = trendNewsList[indexPath.row].source?.name
            cell.publishTimeLabel.text = Utilities.publishDateFormat(publishedAt: trendNewsList[indexPath.row].publishedAt)
            cell.imageView.kf.setImage(with: URL(string: trendNewsList[indexPath.row].urlToImage ?? Utilities.emptyURL))
            cell.imageView.layer.cornerRadius = 12
            cell.layer.borderColor = UIColor.secondarySystemBackground.cgColor
            cell.layer.cornerRadius = 10
            return cell
        }else if collectionView == lastestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastestNewsCell", for: indexPath) as! LastestNewsCollectionViewCell
            cell.titleLabel.text = lastestList[indexPath.row].content
            cell.imageView.kf.setImage(with: URL(string: lastestList[indexPath.row].urlToImage ?? Utilities.emptyURL))
            cell.imageView.layer.cornerRadius = 12
            cell.layer.borderColor = UIColor.secondarySystemBackground.cgColor
            cell.layer.cornerRadius = 10
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topHeadCollectionView {
            goDetail(list: topHeadList, indexPath: indexPath)
        }else if collectionView == trendingCollectionView {
            goDetail(list: trendNewsList, indexPath: indexPath)
        }else if collectionView == lastestCollectionView {
            goDetail(list: lastestList, indexPath: indexPath)
        }
    }
    
    func goDetail(list: [Article], indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.newsResponseModel = list[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func topHeadlinesFetched(_ articles: [Article]) {
        topHeadList = articles
        DispatchQueue.main.async {
            self.topHeadCollectionView.reloadData()
        }
        pageControl.numberOfPages = topHeadList.count
    }
    
    func trendNewsFetched(_ articles: [Article]) {
        trendNewsList = articles
        DispatchQueue.main.async {
            self.trendingCollectionView.reloadData()
        }
    }
    
    func LastestNewsFetched(_ articles: [Article]) {
        lastestList = articles
        DispatchQueue.main.async {
            self.lastestCollectionView.reloadData()
        }
    }
}
