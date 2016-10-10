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
        
        self.navigationItem.title = self.healthUnit?.unitName
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        self.lblCategory.text = healthUnit?.category
        if let street = healthUnit?.address.street! {
            if let city = healthUnit?.address.city!{
                self.lblAddress.text = "\(street), \(city)"
            }
        } else {
            self.lblAddress.text = "Endereço não informado"
        }
        
        self.resetBackgroundColorsForServices()
        
        if healthUnit?.services["temDialise"] == "Sim" {
            self.lblServiceDialise.backgroundColor = UIColor(red: 45, green: 215, blue: 45)
        }
        if healthUnit?.services["temNeoNatal"] == "Sim" {
            self.lblServiceNeoNatal.backgroundColor = UIColor(red: 45, green: 215, blue: 45)
        }
        if healthUnit?.services["temObstetra"] == "Sim" {
            self.lblServiceObstetra.backgroundColor = UIColor(red: 45, green: 215, blue: 45)
        }
        if healthUnit?.services["temCentroCirurgico"] == "Sim" {
            self.lblServiceCentroCirurgico.backgroundColor = UIColor(red: 45, green: 215, blue: 45)
        }
        if healthUnit?.services["temAtendimentoUrgencia"] == "Sim" {
            self.lblServiceAtendimentoUrgencia.backgroundColor = UIColor(red: 45, green: 215, blue: 45)
        }
        if healthUnit?.services["temAtendimentoAmbulatorial"] == "Sim" {
            self.lblServiceAtendimentoAmbulatorial.backgroundColor = UIColor(red: 45, green: 215, blue: 45)
        }
        
        self.lblSchedule.text = healthUnit?.schedule
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    private func resetBackgroundColorsForServices(){
        self.lblServiceDialise.backgroundColor = UIColor.red
        self.lblServiceNeoNatal.backgroundColor = UIColor.red
        self.lblServiceObstetra.backgroundColor = UIColor.red
        self.lblServiceCentroCirurgico.backgroundColor = UIColor.red
        self.lblServiceAtendimentoUrgencia.backgroundColor = UIColor.red
        self.lblServiceAtendimentoAmbulatorial.backgroundColor = UIColor.red
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

