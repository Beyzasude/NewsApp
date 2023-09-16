//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 14.09.2023.
//

import UIKit
import Kingfisher
import CoreData

class NewsDetailViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishTimeLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var isFav: Bool = false
    var newsResponseModel : Article?
    var dateStringFormat: String?
    let viewModel = NewsDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setData()
        fetchFavNews()
        publishDateFormat()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func setData(){
       
        titleLabel.text = newsResponseModel?.title ?? "Autoworkers strike begins at Ford, GM, Stellantis plants | TechCrunch"
        sourceLabel.text = newsResponseModel?.source?.name ?? "TechCrunch"
        newsImageView.kf.setImage(with: URL(string: newsResponseModel?.urlToImage ?? "https://techcrunch.com/wp-content/uploads/2023/09/Screen-Shot-2023-09-15-at-4.00.52-pm.png?w=1074"))
        newsImageView.layer.cornerRadius = 5
        authorNameLabel.text = newsResponseModel?.author ?? "Rebecca Bellan"
        publishTimeLabel.text = dateStringFormat
        newsContentLabel.text = newsResponseModel?.content ?? "The United Autoworkers Union (UAW) will go through with threats to strike against the Big Three automakers — Ford, General Motors and Stellantis — after both sides failed to reach a deal. This is the… [+8631 chars]"
    }
    
    func publishDateFormat(){
        //gelen tarihi formatlama
        let dateString = newsResponseModel?.publishedAt ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            dateFormatter.locale = Locale(identifier: "en_US")
            let formattedDate = dateFormatter.string(from: date)
            print(formattedDate)
            dateStringFormat = formattedDate
            publishTimeLabel.text = dateStringFormat
        } else {
            print("Invalid date format.")
        }
    }
    
    func saveFavNews(){
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
        isFav = true
        changeFavButton()
    }
    
    func changeFavButton(){
        if isFav == true {
            favoriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    private func fetchFavNews(){
        do {
            let results = try context.fetch(FavoriteNewsModel.fetchRequest())
            if let newsId = newsResponseModel?.publishedAt {
                isFav = results.contains { $0.id == newsId }
                if isFav {
                    changeFavButton()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func shareButtonAct(_ sender: Any) {
    }
    
    @IBAction func addFavoriteButtonAct(_ sender: Any) {
        if isFav {
            do {
                let newsId = newsResponseModel?.publishedAt ?? ""
                let results = try context.fetch(FavoriteNewsModel.fetchRequest())
                if let favoriteNews = results.first(where: { $0.id == newsId }) {
                    context.delete(favoriteNews)
                    appDelegate.saveContext()
                    isFav = false
                    changeFavButton()
                }
            } catch {
                print("error")
            }
        } else {
            saveFavNews()
        }
    }
    
    @IBAction func readMoreButtonAct(_ sender: Any) {
        if let webVC = storyboard?.instantiateViewController(withIdentifier: "DetailWebViewController") as? DetailWebViewController {
            webVC.urlString = newsResponseModel?.url
            self.present(webVC, animated: true)
        }
    }
    
}
