//
//  DetailNewsViewController.swift
//  NewsFeed
//
//  Created by Vishwanath on 11/08/21.
//

import UIKit

class DetailNewsViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var sourceImg: UIImageView!
    var article : Articles? = nil
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = true
        titleLbl.text = article?.title
        sourceLbl.text = (article?.url)! as String
        descriptionTxtView.text = article?.description
        loadingIndicator.isHidden = false
        let url : NSURL? = NSURL(string:(article?.urlToImage!)!)
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url! as URL) else {
                return
            }
            DispatchQueue.main.async { [self] in
                sourceImg.image = UIImage(data: data)
                loadingIndicator.stopAnimating()
                loadingIndicator.isHidden = true
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleUrl(_:)))
        sourceLbl.addGestureRecognizer(tap)
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleUrl(_ sender: UITapGestureRecognizer? = nil) {
        if let url = URL(string: (article?.url)!) {
            UIApplication.shared.open(url)
        }
    }
}
