//
//  Helper.swift
//  ImageEditot
//
//  Created by Unique Consulting Firm on 24/04/2024.
//

import Foundation
import UIKit

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UILabel {

    @IBInspectable var borderWidth2: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius2: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor2: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UIView {

    @IBInspectable var borderWidth1: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius1: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor1: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

func roundCorner(button:UIButton)
{
    button.layer.cornerRadius = button.frame.size.height/2
    button.clipsToBounds = true
}
func viewShadow (view:UIView)
{
    // Set up shadow properties
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowOpacity = 0.3
    view.layer.shadowRadius = 4.0
    view.layer.masksToBounds = false
      
      // Set background opacity
    //contentView.alpha = 0.9 // Adjust opacity as needed
}


struct Transaction: Codable,Equatable {
    var amount: String
    var type: String // "Income" or "Expense"
    var reason: String
    var dateTime: Date
    var budget:String
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
           return lhs.amount == rhs.amount &&
               lhs.type == rhs.type &&
               lhs.reason == rhs.reason &&
               lhs.dateTime == rhs.dateTime &&
               lhs.budget == rhs.budget
       }
}

var currency = ""

func formatAmount(_ amount: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    
    // Convert amount to a number
    if let number = formatter.number(from: amount) {
        return formatter.string(from: number) ?? amount
    } else {
        // If conversion fails, assume there's no dot and add two zeros after it
        let amountWithDot = amount + ".00"
        return formatter.string(from: formatter.number(from: amountWithDot)!) ?? amountWithDot
    }
}

extension UIViewController
{
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.purple
        toastLabel.textColor = UIColor.black
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}


extension UIView {
    func showToast(message: String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 75, y: self.frame.size.height - 100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.purple
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}

struct Item {
    let title: String
    let details: String
    var isExpanded: Bool
}
var items: [Item] = [
      Item(title: "What are Medicine?", details: "Medicines, often referred to as drugs, are used to prevent or treat diseases and other health conditions. Medicines can be obtained by a prescription or over the counter (OTC). Prescription drugs are medicines that you can get only with a doctor’s order; for example, pills to lower your cholesterol or an asthma inhaler. OTC medications can be purchased without a prescription; for example, aspirin or lubricating eye drops.", isExpanded: false),
      Item(title: "Starting a new medicine", details: "Talk with your health care provider before starting any new prescription, OTC medicine, or supplement, and ensure that your provider knows everything else you are taking. Discuss any allergies or problems you have experienced with other medicines. These might include rashes, trouble breathing, indigestion, dizziness, or mood changes. Make sure your doctor and pharmacist have an up-to-date list of your allergies so they don’t give you a medicine that contains something that could cause an allergic reaction.", isExpanded: false),
      Item(title: "Filling your prescription", details: "When you get your prescriptions filled, the pharmacist can answer many of your questions about prescription drugs, OTC medicines, and supplements. Try to have all your prescriptions filled at the same pharmacy so your records are in one place. This will help alert the pharmacist if a new drug might cause a problem with something else you’re taking. If you’re unable to use just one pharmacy, share your list of medicines and supplements with the pharmacist at each location when you drop off your prescription.", isExpanded: false),Item(title: "Medication side effects", details: "Unwanted or unexpected symptoms or feelings that occur when you take medicine are called side effects. Side effects can be relatively minor, such as a headache or a dry mouth. They can also be life-threatening, such as severe bleeding or damage to the liver or kidneys. The side effects of some medications can also affect your driving.", isExpanded: false),Item(title: "Keeping track of your medicines", details: "Write down all medicines you take, including OTC drugs. Also include any vitamins or dietary supplements. The list should include the name of each medicine or supplement, the amount you take, and time(s) you take it. If it’s a prescription drug, also note the doctor who prescribed it and the reason it was prescribed. Show the list to all your health care providers, including physical therapists and dentists. Keep one copy in a safe place at home and one in your wallet or purse.", isExpanded: false),Item(title: "Taking medicines safely", details: " Read all medicine labels and be sure to follow instructions. Don’t take a larger dose of a medicine, thinking it will help you more. This could be very dangerous and even deadly. And don’t skip or take half doses of a prescription drug to save money.Don’t take medicine in the dark; you might make a mistake. Call your doctor right away if you have any trouble with your prescriptions, OTC medicines, or supplements. There may be something else you can take.", isExpanded: false)
     
  ]

var medsNameList = ["Aspirin","Ibuprofen","Paracetamol","Amoxicillin","Ciprofloxacin","Metformin","Lisinopril","Omeprazole","Atorvastatin","Metoprolol","Losartan","Albuterol","Simvastatin","Clopidogrel","Levothyroxine","Gabapentin","Montelukast","Prednisone","Warfarin","Azithromycin","Furosemide","Amlodipine","Ranitidine","Citalopram","Sertraline","Fluoxetine","Tramadol","Benzonatate","Cetirizine","Lorazepam","Doxycycline","Pantoprazole","Clindamycin","Acetaminophen","Codeine","Insulin","Nitroglycerin","Famotidine","Meloxicam","Zolpidem"]


struct Medication:Codable {
    
    let Uid : String
    let name: String
    let courseDays : String
    let dose: String
    let times: [Date] // Array to store scheduled times
}

func generateRandomCharacter() -> Character {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return characters.randomElement()!
}

// Example usage


