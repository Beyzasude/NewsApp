//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 13.09.2023.
//

import Foundation
import Alamofire
import UIKit

//var language = (UIApplication.shared.delegate as! AppDelegate).language
enum Path {
    case fetchTopHeadLines
    case fetchTrendNews
    case fetchLastestNews
    case fetchCategoryNews(categoryName: String)
    case search(searchText: String)
    
    var path: URL {
        switch self {
        case .fetchTopHeadLines:
            return URL(string: "\(baseUrl)/top-headlines?sources=engadget&apiKey=\(apiKey)")!
        case .fetchTrendNews:
            return URL(string: "\(baseUrl)/top-headlines?country=us&category=general&apiKey=\(apiKey)")!
        case .fetchLastestNews:
            return URL(string: "\(baseUrl)/everything?domains=wsj.com&apiKey=\(apiKey)")!
        case .search(let searchText):
            return URL(string: "\(baseUrl)/everything?q=\(searchText)&apiKey=\(apiKey)")!
        case .fetchCategoryNews(let categoryName):
            return URL(string: "\(baseUrl)/top-headlines?country=us&category=\(categoryName)&apiKey=\(apiKey)")!
        }
        
    }
    
    var baseUrl: String {
        return "https://newsapi.org/v2"
    }
    
    var apiKey: String {
        return "d515f23b8571415681adbfe10bc22673"
    }
}

struct Resource<T: Decodable> {
    var url: Path
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(resource: Resource<T>, succesData: @escaping (NewsModel) -> Void){
        
        AF.request(resource.url.path, method:.get, encoding:JSONEncoding.default, headers: nil, interceptor: nil).response{
            (responseData) in
            
            guard let data = responseData.data else { return }
            
            do{
                let topHeadlinesModel = try? JSONDecoder().decode(NewsModel.self, from: data)
                succesData(topHeadlinesModel!)
            }
        }
    }
}


