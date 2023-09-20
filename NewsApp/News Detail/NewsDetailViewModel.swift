//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 15.09.2023.
//

import Foundation
import UIKit
import CoreData

protocol NewsDetailViewModelProtocol {
    var view : NewsDetailControllerProtocol? { get set }
}

class NewsDetailViewModel : NewsDetailViewModelProtocol{
    let context = appDelegate.persistentContainer.viewContext
    var isFavorite: Bool = false
    
    weak var view: NewsDetailControllerProtocol?
    
    func fetchFavNews(newsResponseModel: Article?){
        do {
            let results = try context.fetch(FavoriteNewsModel.fetchRequest())
            if let newsId = newsResponseModel?.publishedAt {
                isFavorite = results.contains { $0.id == newsId }
                if isFavorite {
                    view?.changeFavButton(isFav: isFavorite)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addFav(newsResponseModel: Article?) {
        if isFavorite {
            do {
                let newsId = newsResponseModel?.publishedAt ?? ""
                let results = try context.fetch(FavoriteNewsModel.fetchRequest())
                if let favoriteNews = results.first(where: { $0.id == newsId }) {
                    context.delete(favoriteNews)
                    appDelegate.saveContext()
                    isFavorite = false
                    view?.changeFavButton(isFav: isFavorite)
                }
            } catch {
                print(error.localizedDescription)
            }
        } else {
            saveFavNews(newsResponseModel: newsResponseModel)
        }
    }
    
    func saveFavNews(newsResponseModel: Article?){
        let context = appDelegate.persistentContainer.viewContext
        let news = FavoriteNewsModel(context: context)
        
        news.id = newsResponseModel?.publishedAt
        news.news_title = newsResponseModel?.title
        news.news_source = newsResponseModel?.source?.name
        news.news_content = newsResponseModel?.content
        news.news_description = newsResponseModel?.description
        news.news_author = newsResponseModel?.author
        news.news_url = newsResponseModel?.url
        news.news_image = newsResponseModel?.urlToImage
        appDelegate.saveContext()
        isFavorite = true
        view?.changeFavButton(isFav: isFavorite)
    }
    
}
