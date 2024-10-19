//
//  AddMedicationViewController.swift
//  PillCare
//
//  Created by Moin Janjua on 13/08/2024.
//

import UIKit

class AddMedicationViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var Add_btn: UIButton!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var UserName_label: UILabel!
    @IBOutlet weak var userImagebtn: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredData = [String]()
    var isSearching = false
    
    var MedicineName = [String]()
    var pillsImages: [UIImage] = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,UIImage(named: "3")!,
        UIImage(named: "5")!,UIImage(named: "33")!,
        UIImage(named: "4")!,UIImage(named: "32")!,
        UIImage(named: "40")!,UIImage(named: "30")!,
        UIImage(named: "8")!,UIImage(named: "6")!,
        UIImage(named: "17")!,UIImage(named: "15")!,
        UIImage(named: "16")!,UIImage(named: "14")!,
        UIImage(named: "7")!,UIImage(named: "26")!,
        UIImage(named: "27")!,UIImage(named: "25")!,
        UIImage(named: "13")!,UIImage(named: "24")!,
        UIImage(named: "12")!,UIImage(named: "23")!,
        UIImage(named: "28")!,UIImage(named: "22")!,
        UIImage(named: "29")!,UIImage(named: "39")!,
        UIImage(named: "31")!,UIImage(named: "9")!,
        UIImage(named: "34")!,UIImage(named: "36")!,
        UIImage(named: "11")!,UIImage(named: "37")!,
        UIImage(named: "10")!,UIImage(named: "38")!,
        UIImage(named: "21")!,UIImage(named: "35")!,
        UIImage(named: "19")!,UIImage(named: "20")!,
        UIImage(named: "18")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        posterImageView.layer.cornerRadius = 20
        Add_btn.layer.cornerRadius = 20
        
        roundCorner(button: userImagebtn)
        MedicineName = medsNameList
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        searchBar.delegate = self
        loadData()
        filteredData = MedicineName
       
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                tapGesture.cancelsTouchesInView = false
                view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard()
      {
          view.endEditing(true)
      }
 
    func loadData() {
            // Load text fields
            UserName_label.text = UserDefaults.standard.string(forKey: "name")

            // Load image
            if let imageData = UserDefaults.standard.data(forKey: "savedImage"), let image = UIImage(data: imageData) {
                userImagebtn.setImage(image, for: .normal)
            }
        }
    @IBAction func AddMedsReminderButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReminderSetViewController") as! ReminderSetViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
    }
    @IBAction func DoseSetButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReminderSetViewController") as! ReminderSetViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
}
extension AddMedicationViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return isSearching ? filteredData.count : MedicineName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddMedsCell", for: indexPath) as! AddMedsCollectionViewCell
        
        cell.Meds_labelNames.text = isSearching ? filteredData[indexPath.item] : MedicineName[indexPath.item]
        cell.Add_Meds_Image.image? = pillsImages [indexPath.item]
        
        return cell
  
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CollectionView.frame.size.width/2-7 , height: CollectionView.frame.size.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item at index \(indexPath.item) selected")
        
        let item = isSearching ? filteredData[indexPath.item] : MedicineName[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let secondVC = storyboard.instantiateViewController(withIdentifier: "ReminderSetViewController")
          as! ReminderSetViewController
        secondVC.modalPresentationStyle = .fullScreen
           secondVC.medician_name = item
        self.present(secondVC, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = MedicineName
            isSearching = false
        } else {
            isSearching = true
            filteredData = MedicineName.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        
        CollectionView.reloadData()
    }

}
