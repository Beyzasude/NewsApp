//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 14.09.2023.
//

import UIKit
import Kingfisher
import CoreData

protocol NewsDetailControllerProtocol : AnyObject {
    func changeFavButton(isFav: Bool)
}

class NewsDetailViewController: UIViewController, NewsDetailControllerProtocol {
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
        viewModel.view = self
        navigationItem.largeTitleDisplayMode = .never
        setData()
        viewModel.fetchFavNews(newsResponseModel: newsResponseModel)
    }
    
    private func setData(){
        
        titleLabel.text = newsResponseModel?.title ?? "Autoworkers strike begins at Ford, GM, Stellantis plants | TechCrunch"
        sourceLabel.text = newsResponseModel?.source?.name ?? "TechCrunch"
        newsImageView.kf.setImage(with: URL(string: newsResponseModel?.urlToImage ?? "https://techcrunch.com/wp-content/uploads/2023/09/Screen-Shot-2023-09-15-at-4.00.52-pm.png?w=1074"))
        newsImageView.layer.cornerRadius = 5
        authorNameLabel.text = newsResponseModel?.author ?? "Rebecca Bellan"
        publishTimeLabel.text = Utilities.publishDateFormat(publishedAt: newsResponseModel?.publishedAt)
        newsContentLabel.text = newsResponseModel?.content ?? "The United Autoworkers Union (UAW) will go through with threats to strike against the Big Three automakers — Ford, General Motors and Stellantis — after both sides failed to reach a deal. This is the… [+8631 chars]"
    }
    
    func changeFavButton(isFav: Bool){
        if isFav == true {
            favoriteButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }else{
            favoriteButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    @IBAction func shareButtonAct(_ sender: Any) {
        let textToShare = "Bu haber harika!"
        let urlToShare = URL(string: newsResponseModel?.url ?? "https://www.example.com")

            var itemsToShare: [Any] = [textToShare]
            if let url = urlToShare {
                itemsToShare.append(url)
            }
            let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func addFavoriteButtonAct(_ sender: Any) {
        viewModel.addFav(newsResponseModel: newsResponseModel)
    }
    
    @IBAction func readMoreButtonAct(_ sender: Any) {
        if let webVC = storyboard?.instantiateViewController(withIdentifier: "DetailWebViewController") as? DetailWebViewController {
            webVC.urlString = newsResponseModel?.url
            self.present(webVC, animated: true)
        }
    }
    
}
