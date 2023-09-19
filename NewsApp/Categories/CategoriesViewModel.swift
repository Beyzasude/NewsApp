//
//  CategoriesViewModel.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 19.09.2023.
//

import Foundation

protocol CategoriesViewModelDelegate: AnyObject {
    func categoryNewsFetched(_ articles: [Article])
}

class CategoriesViewModel {
    weak var delegate: CategoriesViewModelDelegate?
    
    func fetchCategoryNews(categoryName: String){
        let resource = Resource<NewsModel>(url: .fetchCategoryNews(categoryName: categoryName))
        NetworkManager.shared.fetchData(resource: resource) { response in
            if let articles = response.articles {
                self.delegate?.categoryNewsFetched(articles)
            } else {
                self.delegate?.categoryNewsFetched([])
            }
        }
    }
}
