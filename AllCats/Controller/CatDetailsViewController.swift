//
//  CatDetailsViewController.swift
//  AllCats
//
//  Created by Astha Ameta on 15/09/22.
//

import UIKit

class CatDetailsViewController: UIViewController, UITextViewDelegate {
   
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var catDetailImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    @IBOutlet weak var wikipediaTextView: UITextView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var catDetails: Cat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scroller.isScrollEnabled = true
        scroller.contentSize = CGSize(width: scroller.contentSize.width, height: scroller.contentSize.height + 200)
    }
    
    func setupUI() {
        if let catDetails = catDetails {
            self.nameLbl.text = catDetails.name
            self.originLbl.text = catDetails.origin
            self.descriptionLbl.text = catDetails.description
            
            let attributedString = NSMutableAttributedString(string: catDetails.wikipediaURL ?? "")
            self.wikipediaTextView.attributedText = attributedString

            loadImage()
        }
    }
    
    func loadImage() {
        if let urlString = catDetails?.image?.url, let url = URL(string: urlString) {
            self.catDetailImgView.load(url: url, placeholder: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false 
    }
}


