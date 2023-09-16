//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 13.09.2023.
//

import Foundation
import Alamofire

enum Path {
    case fetchTopHeadLines
    case fetchTrendNews
    case fetchLastestNews
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


//func sil(_ kisi_id: Int){
//    let url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php"
//     let params: Parameters = ["kisi_id": kisi_id]
//
//     AF.request(url, method: .post, parameters: params).response { response in
//         if let data = response.data {
//             do {
//                 let crudCevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
//                 print("----------- Kişi Sil-----------")
//                 print("Başarı : \(crudCevap.success!)")
//                 print("Message: \(crudCevap.message!)")
//             }catch{
//                 print(error.localizedDescription)
//             }
//         }
//     }
//}

//func ara(_ aramaKelimesi: String){
//    let url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php"
//     let params: Parameters = ["kisi_ad": aramaKelimesi]
//
//    AF.request(url, method: .post, parameters: params).response { response in
//         if let data = response.data {
//             do {
//                 let KisilerCevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
//                 if let liste = KisilerCevap.kisiler {
//                     self.kisilerListesi.onNext(liste) //tetikleme
//                 }
//             }catch{
//                 print(error.localizedDescription)
//             }
//         }
//     }
//}
