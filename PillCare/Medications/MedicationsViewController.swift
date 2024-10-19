import UIKit

class MedicationsViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var noDataImageView: UIImageView! // Add this outlet
    
    var medications: [Medication] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        TableView.delegate = self
        TableView.dataSource = self
        
        // Initially hide the no data image view
        noDataImageView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load data from UserDefaults
        if let savedData = UserDefaults.standard.array(forKey: "medications") as? [Data] {
            let decoder = JSONDecoder()
            medications = savedData.compactMap { data in
                do {
                    let medication = try decoder.decode(Medication.self, from: data)
                    return medication
                } catch {
                    print("Error decoding medication: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        
        // Show or hide the no data image view
        noDataImageView.isHidden = !medications.isEmpty
        TableView.reloadData()
    }
}

extension MedicationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemindMedsCell", for: indexPath) as! TableViewCellMeds
        
        let medication = medications[indexPath.row]
        cell.name_lbl?.text = medication.name
        cell.quantity_lbl?.text = "Dose : \(medication.dose)"
        cell.hm_daysLbl?.text = "Course Days: \(medication.courseDays)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
        if let firstTime = medication.times.first {
                cell.date_lbl?.text = dateFormatter.string(from: firstTime)
            } else {
                // Display a default message if there are no times
                cell.date_lbl?.text = "Time not set"
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            medications.remove(at: indexPath.row)
            
            let encoder = JSONEncoder()
            do {
                let encodedData = try medications.map { try encoder.encode($0) }
                UserDefaults.standard.set(encodedData, forKey: "medications")
            } catch {
                print("Error encoding medications: \(error.localizedDescription)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Update UI after deletion
            noDataImageView.isHidden = !medications.isEmpty
        }
    }
}
