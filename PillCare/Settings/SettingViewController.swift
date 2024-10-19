//
//  SettingViewController.swift
//  PillCare
//
//  Created by Moin Janjua on 13/08/2024.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    
    var Name = [String]()
    var Images: [UIImage] = [
        UIImage(named: "homepage")!,
        UIImage(named: "_eedback_")!,
        UIImage(named: "about us")!,
        UIImage(named: "policy_")!,
        UIImage(named: "share")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Name = ["Home","Feedback","About Us","Private Policy","Share App"]
        
        TableView.delegate = self
        TableView.dataSource = self
    }
}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingTableViewCell
        cell.s_Label.text = Name [indexPath.row]
        cell.s_Image.image? = Images [indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
            
        } else if indexPath.item == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
            
        }
        else if indexPath.item == 2 {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.item == 3 {
            // Open Privacy Policy Link
            if let url = URL(string: "https://jtechapps.pages.dev/privacy") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
        else if indexPath.item == 4 {
            
            let appID = "PillCare" // Replace with your actual App ID
            let appURL = URL(string: "https://apps.apple.com/app/id\(appID)")!
            let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
            
        }
    }
}
