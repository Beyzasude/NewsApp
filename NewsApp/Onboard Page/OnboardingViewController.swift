//
//  OnboardingViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var image1 = UIImage(named: "1")
    var image2 = UIImage(named: "2")
    var image3 = UIImage(named: "3")
    
    var slides: [OnboardingModel] = []
    var showBoard = true
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1{
                nextButton.setTitle("Get Started", for:.normal)
                
            } else {
                nextButton.setTitle("Next", for:.normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewUI()
         slides = [
            OnboardingModel(title: "Get the lastest news From reliable sources.", image:image1!),
            OnboardingModel(title: "From art to politics, anything in BFNews.", image:image2!),
            OnboardingModel(title: "Still up to date news from all around the world.", image:image3!)
            ]

    }
    
    private func collectionViewUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @IBAction func nextButtonAct(_ sender: Any) {
        if currentPage == slides.count - 1 {
            UserDefaults.standard.set(showBoard, forKey: "showOnboard")
            performSegue(withIdentifier: "signInSignUp", sender:nil)
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section:0)
            nextButton.setTitleColor(.white, for:.normal)
            collectionView.scrollToItem(at: indexPath, at:.centeredHorizontally, animated: true)
        }
    }
    
}
extension OnboardingViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.titleLabel.text = slides[indexPath.row].title
        cell.imageView.image = slides[indexPath.row].image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
    }

}
