//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by STARKS on 8/18/19.
//  Copyright © 2019 STARKS. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import SwiftyJSON
import SDWebImage
import Toast_Swift
import SVProgressHUD_0_8_1
class NewsFeedViewController: UIViewController {
    var c = 0;
 
    @IBOutlet var titleLabel: UILabel!
    var htmlUrl = ""
    @IBOutlet var imgView: UIImageView!
    
    
    @IBOutlet var textView: UITextView!
    let url = "https://newsapi.org/v2/top-headlines?" +
        "country=in&" +
    "apiKey=1f7ef768974c4efa9059ec56d35380a1"
    override func viewDidLoad() {

        super.viewDidLoad()
       // self.present(ViewController(), animated: false, completion: nil)
       
       
        SVProgressHUD.show(withStatus: "Loading")
            get_news(url: url,i: 0)
       
     
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        // Do any additional setup after loading the view.
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if sender.direction == .left{
            if(c<20)
            {c = c+1;
                print("####",c);
                get_news(url: url, i: c)
            }
            else
            {
                self.view.makeToast("News Feed Up To Date Comeback After 15 Mins")
            }
        }
        if sender.direction == .right{
            if(c>0)
            {
            c=c-1;
            print("####",c);
            get_news(url: url, i: c)
            }
            else
            {
                self.view.makeToast("Swife Left or Refresh To Load More News")
            }
        }
        
        
    }
    
    func get_news(url:String,i: Int)
    {
        AF.request(url, method: .get).responseJSON { response in
            switch response.result{
                
    
            case let .success(value):
                
                let newsJSON : JSON = JSON(value)
                
                
               // print(newsJSON)
                self.updateFeed(json: newsJSON,i: i)
                
                
                
            case .failure(let error):
                print(error)
                
            }
        
        }
    }

    func updateFeed(json : JSON,i : Int)
    {
        
        if let titleLab = json["articles"][i]["title"].string{
            
            titleLabel.text = titleLab
        }
        
        if let newsText = json["articles"][i]["description"].string
        {
            textView.text = newsText
        }
        if let newsImg = json["articles"][i]["urlToImage"].string{
            
            imgView?.sd_setImage(with: URL(string: newsImg))
            imgView.contentMode = .scaleToFill
            
        }
        if let newsUrl = json["articles"][i]["url"].string{
            
            htmlUrl = newsUrl
            
        }
        SVProgressHUD.dismiss()
        
        
    }
    
    
    
    @IBAction func refreshBtnPressed(_ sender: Any) {
     get_news(url: url,i: 0)
    }
    
    
    @IBAction func viewFullStory(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string:htmlUrl)! as URL)
    }
   
   
}
