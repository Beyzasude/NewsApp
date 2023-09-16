//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 13.09.2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func topHeadlinesFetched(_ articles: [Article])
    func trendNewsFetched(_ articles: [Article])
    func LastestNewsFetched(_ articles: [Article])
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?

    func fetchTopHeadlines() {
        let resource = Resource<NewsModel>(url: .fetchTopHeadLines)
        NetworkManager.shared.fetchData(resource: resource) { response in
            if let articles = response.articles {
                self.delegate?.topHeadlinesFetched(articles)
            } else {
                self.delegate?.topHeadlinesFetched([])
            }
        }
    }
    
    func fetchTrendNews() {
        let resource = Resource<NewsModel>(url: .fetchTrendNews)
        NetworkManager.shared.fetchData(resource: resource) { response in
            if let articles = response.articles {
                self.delegate?.trendNewsFetched(articles)
            } else {
                self.delegate?.trendNewsFetched([])
            }
        }
    }
    
    func fetchLastestNews(){
        let resource = Resource<NewsModel>(url: .fetchLastestNews)
        NetworkManager.shared.fetchData(resource: resource) { response in
            if let articles = response.articles {
                self.delegate?.LastestNewsFetched(articles)
            } else {
                self.delegate?.LastestNewsFetched([])
            }
        }
    }
}
