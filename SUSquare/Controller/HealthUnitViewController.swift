//
//  HealthUnitViewController.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit

class HealthUnitViewController: UIViewController {
    
    let healthUnit = ["Unidade de Saude Modelo", "Simone Stumpf", "Clinica Dallavinci Servicos Medicos Sociedade Simples", "Ernani Miura"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HealthUnitViewController : UITableViewDelegate {

}

extension HealthUnitViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthUnit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "healthUnitIdentifier", for: indexPath) as! HealthUnitTableViewCell
            
        cell.lblHealthUnit.text = healthUnit[indexPath.row]
        
        return cell
        
    }
}
