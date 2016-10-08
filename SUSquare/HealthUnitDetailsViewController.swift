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
    
    @IBOutlet weak var lblServiceDialise: UILabel!
    @IBOutlet weak var lblServiceNeoNatal: UILabel!
    @IBOutlet weak var lblServiceObstetra: UILabel!
    @IBOutlet weak var lblServiceCentroCirurgico: UILabel!
    @IBOutlet weak var lblServiceAtendimentoUrgencia: UILabel!
    @IBOutlet weak var lblServiceAtendimentoAmbulatorial: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(healthUnit)
        
        self.lblCategory.text = healthUnit?.category
        if let street = healthUnit?.address, let number = healthUnit?.address.number{
            self.lblAddress.text = "\(street), \(number)"
        } else {
            self.lblAddress.text = "Endereço não informado"
        }
        self.lblSchedule.text = healthUnit?.schedule
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

