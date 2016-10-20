//
//  AboutMeViewController.swift
//  SUSquare
//
//  Created by AGES1 on 20/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {
    
    let aboutMeOptions = ["História","Equipe","Parceiros"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AboutMeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutMeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutMeCell", for: indexPath) as! AboutMeTableViewCell
        
        cell.titleLabel.text = aboutMeOptions[indexPath.row]
        cell.titleLabel.textColor = UIColor(red: 139, green: 216, blue: 217)
        return cell
    }
}

extension AboutMeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row{
        case 0: performSegue(withIdentifier: "historySegue", sender: nil)
        case 1: performSegue(withIdentifier: "teamSegue", sender: nil)
        case 2: performSegue(withIdentifier: "partnersSegue", sender: nil)
        default: ""
        }
    }
}
