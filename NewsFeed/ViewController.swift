//
//  ViewController.swift
//  NewsFeed
//
//  Created by STARKS on 8/18/19.
//  Copyright © 2019 STARKS. All rights reserved.
//

import UIKit
import Lottie
class ViewController: UIViewController {

    @IBOutlet var animationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnim()
        // Do any additional setup after loading the view.
    }
func startAnim()
{
    
    animationView.animation = Animation.named("new")
    animationView.play { (data) in
        self.performSegue(withIdentifier: "news", sender: nil)
    }


}
}
