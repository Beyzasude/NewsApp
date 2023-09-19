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
        fetchFavNewsList()
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
        cell.titleLabel.text = favoriteList[indexPath.row].news_title
        cell.descriptionLabel.text = favoriteList[indexPath.row].news_description
        cell.sourceLabel.text = favoriteList[indexPath.row].news_source
        cell.favorimageView.kf.setImage(with: URL(string:favoriteList[indexPath.row].news_image ?? Utilities.emptyURL ))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        let favoriteNews = favoriteList[indexPath.row]
            let article = Article(
                source: Source(name: favoriteNews.news_source),
                author: favoriteNews.news_author,
                title: favoriteNews.news_title,
                description: favoriteNews.news_description,
                url: favoriteNews.news_url,
                urlToImage: favoriteNews.news_image,
                publishedAt: favoriteNews.id,
                content: favoriteNews.news_content
            )
            vc.newsResponseModel = article
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
