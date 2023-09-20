//
//  SearchViewModel.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 20.09.2023.
//

import Foundation
import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func searchNewsFetched(_ articles: [Article])
}

class SearchViewModel {
    weak var delegate: SearchViewModelDelegate?
    weak var view: UIView?  // Add a reference to the view or view controller
    
    func fetchSearchList(searchText: String) {
        let resource = Resource<NewsModel>(url: .search(searchText: searchText))
        NetworkManager.shared.fetchData(resource: resource) { response in
            if let articles = response.articles {
                self.delegate?.searchNewsFetched(articles)
            } else {
                self.delegate?.searchNewsFetched([])
            }
        }
    }
}
