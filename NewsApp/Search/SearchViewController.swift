//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 11.09.2023.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel = SearchViewModel()
    var searchList : [Article]?
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        labelSet()
        tableViewSet()
        configureNavBarWithLogoImage()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchSearchList(searchText: "business")
        self.tableView.reloadData()
    }
    
    func labelSet() {
        label.text = "No search results found"
        label.textColor = UIColor.systemRed
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.sizeToFit()
        
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        label.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        label.isHidden = true
        view.addSubview(label)
    }
    
    func tableViewSet() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            viewModel.fetchSearchList(searchText: "business")
        } else {
            viewModel.fetchSearchList(searchText: searchText)
            if self.searchList?.count == 0 {
                
                self.tableView.isHidden = true
                self.label.isHidden = false
            }else{
                self.tableView.isHidden = false
                self.label.isHidden = true
            }
        }
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        cell.titleLabel.text = searchList?[indexPath.row].title
        cell.descriptionLabel.text = searchList?[indexPath.row].description
        cell.sourceLabel.text = searchList?[indexPath.row].source?.name
        cell.searchImageView.kf.setImage(with: URL(string:searchList?[indexPath.row].urlToImage ?? Utilities.emptyURL), placeholder:UIImage(named:"image"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.newsResponseModel = searchList?[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchViewController: SearchViewModelDelegate {
    func searchNewsFetched(_ articles: [Article]) {
        searchList = articles
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

