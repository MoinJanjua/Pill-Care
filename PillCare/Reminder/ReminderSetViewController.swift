import UIKit
import UserNotifications

class ReminderSetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Set_Btn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var Date_Textfield: UITextField!
    @IBOutlet weak var medicianName_Textfield: UITextField!
    @IBOutlet weak var CourseDaysTF: UITextField!
    @IBOutlet weak var DoseQuantity_txtfield: UITextField!
    @IBOutlet weak var timePickersStackView: UIStackView!
    @IBOutlet weak var notifswitch: UISwitch!
    
    var numberOfDosesPerDay: Int = 3
    var medician_name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [self] granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
            
        }
        Set_Btn.layer.cornerRadius = 20
        Set_Btn.clipsToBounds = true
        
        timeLbl.text = getCurrentDate()
        medicianName_Textfield.text = medician_name
        
        DoseQuantity_txtfield.delegate = self
        medicianName_Textfield.delegate = self
        CourseDaysTF.delegate = self
      
        
        notifswitch.isOn = true
        let switchState = UserDefaults.standard.value(forKey: "notificationSwitch") as? Bool ?? true
        notifswitch.isOn = switchState
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                tapGesture.cancelsTouchesInView = false
                view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard()
      {
          view.endEditing(true)
      }
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        return formatter.string(from: Date())
    }
    
    func clearTextFields() {
        DoseQuantity_txtfield.text = ""
        medicianName_Textfield.text = ""
        CourseDaysTF.text = ""
    }
    
    func scheduleNotifications(_ sender: Any) {
        guard let medicineName = medicianName_Textfield.text, !medicineName.isEmpty,
              let dosage = DoseQuantity_txtfield.text, !dosage.isEmpty,
              let coursdays = CourseDaysTF.text, !coursdays.isEmpty else {
            showAlert(message: "Please fill in all fields")
            return
        }
        
        var medicationTimes = [Date]()
        
        for stackView in timePickersStackView.arrangedSubviews {
            // Ensure we're dealing with a UIStackView
            if let horizontalStackView = stackView as? UIStackView {
                for subview in horizontalStackView.arrangedSubviews {
                    if let timePicker = subview as? UIDatePicker, notifswitch.isOn {
                        let scheduledTime = timePicker.date
                        let notificationTime = Calendar.current.date(byAdding: .minute, value: -10, to: scheduledTime) ?? Date()
                        
                        scheduleNotification(title: "Time to take medicine", body: "Don't forget to take your medication!", date: scheduledTime)
                        scheduleNotification(title: "Dose Time Reminder", body: "Your dose will start in the next 10 minutes.", date: notificationTime)
                        
                        medicationTimes.append(scheduledTime)
                    }
                }
            }
        }
        
        let randomCharacter = generateRandomCharacter()
        let newMedication = Medication(Uid: "\(randomCharacter)", name: medicineName, courseDays: coursdays, dose: dosage, times: medicationTimes)
        saveMedication(newMedication)
    }

    func saveMedication(_ medication: Medication) {
        var medications = UserDefaults.standard.object(forKey: "medications") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(medication)
            medications.append(data)
            UserDefaults.standard.set(medications, forKey: "medications")
            clearTextFields()
            timePickersStackView.subviews.forEach { $0.removeFromSuperview() }
        } catch {
            print("Error encoding medication: \(error.localizedDescription)")
        }
        showAlert(title: "Done", message: "Reminder Dose has been set successfully.")
    }
    
    func scheduleNotification(title: String, body: String, date: Date) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    
    func setupTimePickers() {
        // Remove existing subviews
        timePickersStackView.subviews.forEach { $0.removeFromSuperview() }
        
        // Set the main stack view to vertical axis
        timePickersStackView.axis = .vertical
        timePickersStackView.spacing = 8 // Adjust the spacing between rows if needed
        
        // Determine the maximum number of pickers per row
        let maxPickersPerRow = 3
        
        // Create a horizontal stack view to hold the time pickers
        var currentRowStackView = UIStackView()
        currentRowStackView.axis = .horizontal
        currentRowStackView.spacing = 8
        currentRowStackView.distribution = .fillEqually
        
        for index in 1...numberOfDosesPerDay {
            let timePicker = UIDatePicker()
            timePicker.datePickerMode = .time
            timePicker.tag = index
            
            let defaultTime = Calendar.current.date(bySettingHour: 9 + index, minute: 0, second: 0, of: Date()) ?? Date()
            timePicker.date = defaultTime
            
            // Add the time picker to the current row stack view
            currentRowStackView.addArrangedSubview(timePicker)
           // timePickersStackView.addArrangedSubview(timePicker)
            // If the current row stack view is full, add it to the main stack view and create a new row
            if currentRowStackView.arrangedSubviews.count == maxPickersPerRow {
              timePickersStackView.addArrangedSubview(currentRowStackView)
                currentRowStackView = UIStackView()
                currentRowStackView.axis = .horizontal
                currentRowStackView.spacing = 8
                currentRowStackView.distribution = .fillEqually
            }
        }
        
        // Add any remaining pickers in the last row stack view to the main stack view
        if currentRowStackView.arrangedSubviews.count > 0 {
            timePickersStackView.addArrangedSubview(currentRowStackView)
        }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if let dose = DoseQuantity_txtfield.text,
               let doseFrequency = Int(dose),
               doseFrequency > 5 {
                showAlert(message: "You cannot enter a dose greater than 5")
                return
            }

            guard let dose = DoseQuantity_txtfield.text,
                  let doseFrequency = Int(dose) else {
                return
            }
            numberOfDosesPerDay = doseFrequency
            setupTimePickers()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == DoseQuantity_txtfield {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func SetReminderButton(_ sender: Any) {
        scheduleNotifications(sender)
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notificationSwitch")
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
