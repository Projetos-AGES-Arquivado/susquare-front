//
//  HealthUnitViewController.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class HealthUnitViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var healthUnits = [HealthUnit]()
    
    var locationManager : CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        if let location = locationManager.location{
            SVProgressHUD.show(withStatus: "Loading HealthUnits")
            let coordinate : CLLocationCoordinate2D = location.coordinate
            RestManager.sharedInstance.requestHealthUnits(byLocation: coordinate, withRange: 10, withBlock: { (units: [HealthUnit]?, error: Error?) in
                if error == nil {
                    for unit in units! {
                        if let name = unit.unitName {
                            self.healthUnits.append(unit)
                            self.tableView.reloadData()
                        }
                    }
                    SVProgressHUD.dismiss()
                } else {
                    print(error)
                    SVProgressHUD.showError(withStatus: error?.localizedDescription)
                }
            })
        }
        locationManager.stopUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "healthUnitDetails"{
            let vcDetails = segue.destination as? HealthUnitDetailsViewController
            if let healthUnit = sender as? HealthUnit{
                vcDetails?.healthUnit = healthUnit
            } else {
                print(sender.customMirror.subjectType)
            }
        }
    }
}

extension HealthUnitViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "healthUnitDetails", sender: healthUnits[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension HealthUnitViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthUnits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "healthUnitIdentifier", for: indexPath) as! HealthUnitTableViewCell
            
        cell.lblHealthUnit.text = healthUnits[indexPath.row].unitName
        
        return cell
    }
}
