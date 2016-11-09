//
//  ViewController.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit

class HealthUnitDetailsViewController: UIViewController {
    
    var healthUnit : HealthUnit?
    
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgHealthUnit: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(healthUnit)
        
        self.lblTitle.text = self.healthUnit?.unitName
        
        
        self.lblCategory.text = healthUnit?.category
        
        if let street = healthUnit?.address.street! {
            if let number = healthUnit?.address.number!{
                if let state = healthUnit?.address.state{
                    if let city = healthUnit?.address.city!{
                        self.lblAddress.text = "\(street),\(number) -\(city) (\(state))"
                    }
                }
            }
        } else {
            self.lblAddress.text = "Endereço não informado"
        }
        
        
        self.lblSchedule.text = healthUnit?.schedule
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didPressFeedback(_ sender: AnyObject) {
        performSegue(withIdentifier: "feedbackSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

