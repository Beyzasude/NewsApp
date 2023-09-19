//
//  MenuListTableViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 18.09.2023.
//

import UIKit

struct MenuItem {
    var name: String?
    var categoryName: String?
}

class MenuListTableViewController: UITableViewController {
    
    var items = [MenuItem(name: "Business", categoryName: "business"),
                 MenuItem(name:"Entertainment", categoryName: "entertainment"),
                 MenuItem(name:"General", categoryName: "general"),
                 MenuItem(name:"Health", categoryName: "health"),
                 MenuItem(name:"Science",categoryName: "science"),
                 MenuItem(name:"Sports", categoryName: "sports"),
                 MenuItem(name:"Technology", categoryName: "technology")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        //cell.textLabel?.textColor = .systemRed
        cell.backgroundColor = .secondarySystemBackground
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CategoriesViewController") as? CategoriesViewController else {return}

        vc.sideMenu = items[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    
       
    }

}
