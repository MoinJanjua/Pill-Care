//
//  WelcomeViewController.swift
//  PillCare
//
//  Created by Moin Janjua on 13/08/2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var letsStart_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        letsStart_btn.layer.cornerRadius = 12
        letsStart_btn.clipsToBounds = true
    }
    
    @IBAction func LetsStartButton(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
       // self.tabBarController?.selectedIndex = 3
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    

}
