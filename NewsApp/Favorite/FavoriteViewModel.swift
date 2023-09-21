//
//  FavoriteViewModel.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 21.09.2023.
//

import Foundation

protocol FavoriteViewModelProtocol {
    var view : FavoriteControllerProtocol? { get set }
}


class FavoriteViewModel {
    let context = appDelegate.persistentContainer.viewContext
    weak var view: FavoriteControllerProtocol?
    
    func deleteFavori(id: String) {
        do{
            let results = try context.fetch(FavoriteNewsModel.fetchRequest())
            if let favoriteNews = results.first(where: { $0.id == id }) {
                context.delete(favoriteNews)
                appDelegate.saveContext()
                view?.fetchFavNewsList()
            }
        }catch {
            print(error.localizedDescription)
        }
        
    }
}
