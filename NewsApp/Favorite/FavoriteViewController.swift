//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 11.09.2023.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    var favoriteList : [FavoriteNewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSet()
        //fetchFavNewsList()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavNewsList()
    }
    
    func tableViewSet() {
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func fetchFavNewsList(){
        do {
            favoriteList = try context.fetch(FavoriteNewsModel.fetchRequest())
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteNewsCell", for: indexPath) as! FavoriteTableViewCell
        cell.titleLabel.text = favoriteList[indexPath.row].news_title ?? "boş"
        cell.descriptionLabel.text = favoriteList[indexPath.row].news_description
        cell.favorimageView.kf.setImage(with: URL(string:favoriteList[indexPath.row].news_image ?? "https://images.unsplash.com/photo-1585829365295-ab7cd400c167?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80" ))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.newsResponseModel?.title = favoriteList[indexPath.row].news_title
        vc.newsResponseModel?.content = favoriteList[indexPath.row].news_content
        vc.newsResponseModel?.source?.name = favoriteList[indexPath.row].news_source
        vc.newsResponseModel?.description = favoriteList[indexPath.row].news_description
        vc.newsResponseModel?.author = favoriteList[indexPath.row].news_author
        vc.newsResponseModel?.url = favoriteList[indexPath.row].news_url
        vc.newsResponseModel?.urlToImage = favoriteList[indexPath.row].news_image
        vc.newsResponseModel?.publishedAt = favoriteList[indexPath.row].id
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
