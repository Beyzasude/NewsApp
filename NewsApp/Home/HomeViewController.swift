//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 10.09.2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topHeadCollectionView: UICollectionView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var lastestCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var todayDateLabel: UILabel!
    

    var topHeadList: [Article] = []
    var trendNewsList: [Article] = []
    var lastestList: [Article] = []
    
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionViewsSet()
        todayDate()
        pageControl.currentPage = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //showActivityIndicator()
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
    
    private func todayDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "E MMMM, yyyy"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        todayDateLabel.text = formattedDate
    }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
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
            cell.imageView.kf.setImage(with: URL(string: topHeadList[indexPath.row].urlToImage!))
            cell.titleLabel.text = topHeadList[indexPath.row].title
            cell.imageView.layer.cornerRadius = 12
            return cell
        }else if collectionView == trendingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trengingNewsCell", for: indexPath) as! TrendingNewsCollectionViewCell
            cell.titleLabel.text = trendNewsList[indexPath.row].title
            cell.sourceLabel.text = trendNewsList[indexPath.row].source?.name
            cell.publishTimeLabel.text = Utilities.publishDateFormat(publishedAt: trendNewsList[indexPath.row].publishedAt) 
            cell.imageView.kf.setImage(with: URL(string: trendNewsList[indexPath.row].urlToImage ?? "https://images.unsplash.com/photo-1585829365295-ab7cd400c167?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80"))
            cell.imageView.layer.cornerRadius = 12
            return cell
        }else if collectionView == lastestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastestNewsCell", for: indexPath) as! LastestNewsCollectionViewCell
            cell.titleLabel.text = lastestList[indexPath.row].content
            cell.imageView.kf.setImage(with: URL(string: lastestList[indexPath.row].urlToImage ?? "https://images.unsplash.com/photo-1585829365295-ab7cd400c167?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80"))
            cell.imageView.layer.cornerRadius = 12
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topHeadCollectionView {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
            vc.newsResponseModel = topHeadList[indexPath.row]
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }else if collectionView == trendingCollectionView {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
            vc.newsResponseModel = trendNewsList[indexPath.row]
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if collectionView == lastestCollectionView {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
            vc.newsResponseModel = lastestList[indexPath.row]
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        //self.hideActivityIndicator()
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

