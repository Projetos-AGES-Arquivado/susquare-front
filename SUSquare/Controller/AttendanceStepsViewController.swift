//
//  AttendanceStepsViewController.swift
//  SUSquare
//
//  Created by Marcus Vinicius Kuquert on 21/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit

final class AttendanceStepsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    typealias CellComponent = (title: String, timestamp: Date?)
    
    
    var tableViewComponents: [CellComponent] = [("Check in", nil)]
    var pickerComponents = ["triagem", "consulta","exame", "procedimento", "checkout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension AttendanceStepsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension AttendanceStepsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewComponents.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var currentCell = UITableViewCell()
        //Last row
        if row == tableViewComponents.count {
            if let cell =  tableView.dequeueReusableCell(withIdentifier: "AttendancePickerTableViewCell") as? AttendancePickerTableViewCell {
                cell.progressImageView?.image = UIImage(named: "bottom")
                cell.pickerView.delegate = self
                cell.pickerView.dataSource = self
                cell.delegate = self
                currentCell = cell
            }
        } else {
            if let cell =  tableView.dequeueReusableCell(withIdentifier: "AttendanceTableViewCell") as? AttendanceTableViewCell {
                if row == tableViewComponents.count - 1 {
                    cell.clearButton.isHidden = false
                } else {
                    cell.clearButton.isHidden = true
                }
                if row == 0 {
                    cell.progressImageView?.image = UIImage(named: "top")
                } else {
                    cell.progressImageView?.image = UIImage(named: "middle")
                }
                cell.delegate = self
                cell.mainLabel.text = tableViewComponents[row].0
                if let date = tableViewComponents[row].1 {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm"
                    let convertedDateString = dateFormatter.string(from:date as Date)
                    cell.bottomLabel.text = convertedDateString
                }
                currentCell = cell
            }
        }
        
        return currentCell
    }
}

extension AttendanceStepsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = pickerComponents[row]
        pickerLabel.textAlignment = .left
        pickerLabel.textColor = UIColor(red: 71, green: 186, blue: 251)
        return pickerLabel
    }
}

extension AttendanceStepsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerComponents.count
    }
}

extension AttendanceStepsViewController: AttendanceTableViewCellDelegate {
    func didTapClearButton(cell: AttendanceTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableViewComponents.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension AttendanceStepsViewController: AttendancePickerTableViewCellDelegate {
    func didTapDoneButton(cell: AttendancePickerTableViewCell, pickerView: UIPickerView, selectedRow: Int) {
        let a : CellComponent = (pickerComponents[selectedRow], Date())
        if pickerComponents[selectedRow] == "checkout"{
            RestManager.attendanceCheckout()
            self.dismiss(animated: true, completion: nil)
        } else {
            RestManager.attendanceProcess(info: a.title)
            tableViewComponents.append(a)
            tableView.reloadData()
        }
    }
}
