//
//  ViewController.swift
//  TheGunnOracle
//
//  Created by Taruna Arora on 9/13/17.
//  Copyright © 2017 RDKhare. All rights reserved.
//

import UIKit
import Kanna
import Alamofire


class ViewController: UITableViewController {
    
    @IBOutlet weak var oracleCell: UITableViewCell!
    
    @IBOutlet weak var newsCell: UITableViewCell!
    @IBOutlet weak var newsLabel: UILabel!
    
    @IBOutlet weak var forumCell: UITableViewCell!
    @IBOutlet weak var forumLabel: UILabel!
    
    @IBOutlet weak var FeaturesCell: UITableViewCell!
    @IBOutlet weak var featuresLabel: UILabel!
    
    @IBOutlet weak var centerfoldCell: UITableViewCell!
    @IBOutlet weak var centerfoldLabel: UILabel!
    
    @IBOutlet weak var sportsCell: UITableViewCell!
    @IBOutlet weak var sportsLabel: UILabel!
    
    @IBOutlet weak var lifestyleCell: UITableViewCell!
    @IBOutlet weak var lifestyleLabel: UILabel!
    
    @IBOutlet weak var changingNarrativeCell: UITableViewCell!
    @IBOutlet weak var changingNarrativeLabel: UILabel!
    
    @IBOutlet weak var settingsCell: UITableViewCell!
    @IBOutlet weak var settingsLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view loaded")
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if defaults.value(forKey: "darkOn") != nil{ // Dark Mode stuff
            if((defaults.value(forKey: "darkOn") as! Bool) == true) { //check if dark mode is on
                
                //sets the colors of elements
                
                self.oracleCell.backgroundColor = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(40.0 / 255.0), blue: CGFloat(54.0 / 255.0), alpha: CGFloat(1.0))
                
                self.tableView.backgroundColor = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(40.0 / 255.0), blue: CGFloat(54.0 / 255.0), alpha: CGFloat(1.0))
                
                self.newsCell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.newsLabel.textColor = UIColor.white
                
                self.forumCell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.forumLabel.textColor = UIColor.white
                
                self.FeaturesCell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.featuresLabel.textColor = UIColor.white
                
                self.centerfoldCell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.centerfoldLabel.textColor = UIColor.white
                
                self.sportsCell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.sportsLabel.textColor = UIColor.white
                
                self.lifestyleCell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.lifestyleLabel.textColor = UIColor.white
                
                self.changingNarrativeCell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.changingNarrativeLabel.textColor = UIColor.white
                
                self.settingsCell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.settingsLabel.textColor = UIColor.white
                
                self.tableView.separatorStyle = .none
                
            }
            
            else { //check if oracleMode mode is on
                
                //sets the colors of elements back to normal
                
                self.oracleCell.backgroundColor = UIColor.white
                
                self.tableView.backgroundColor = UIColor.white
                
                self.newsCell.backgroundColor = UIColor.white
                self.newsLabel.textColor = UIColor.black
                
                self.forumCell.backgroundColor = UIColor.white
                self.forumLabel.textColor = UIColor.black
                
                self.FeaturesCell.backgroundColor = UIColor.white
                self.featuresLabel.textColor = UIColor.black
                
                self.centerfoldCell.backgroundColor = UIColor.white
                self.centerfoldLabel.textColor = UIColor.black
                
                self.sportsCell.backgroundColor = UIColor.white
                self.sportsLabel.textColor = UIColor.black
                
                self.lifestyleCell.backgroundColor = UIColor.white
                self.lifestyleLabel.textColor = UIColor.black
                
                self.changingNarrativeCell.backgroundColor = UIColor.white
                self.changingNarrativeLabel.textColor = UIColor.black
                
                self.settingsCell.backgroundColor = UIColor.white
                self.settingsLabel.textColor = UIColor.black
                
                self.tableView.separatorStyle = .singleLine
                
            }
        }
            
        else { //check if oracleMode mode is on
            
            //sets the colors of elements back to normal
            
            self.oracleCell.backgroundColor = UIColor.white
            
            self.tableView.backgroundColor = UIColor.white
            
            self.newsCell.backgroundColor = UIColor.white
            self.newsLabel.textColor = UIColor.black
            
            self.forumCell.backgroundColor = UIColor.white
            self.forumLabel.textColor = UIColor.black
            
            self.FeaturesCell.backgroundColor = UIColor.white
            self.featuresLabel.textColor = UIColor.black
            
            self.centerfoldCell.backgroundColor = UIColor.white
            self.centerfoldLabel.textColor = UIColor.black
            
            self.sportsCell.backgroundColor = UIColor.white
            self.sportsLabel.textColor = UIColor.black
            
            self.lifestyleCell.backgroundColor = UIColor.white
            self.lifestyleLabel.textColor = UIColor.black
            
            self.changingNarrativeCell.backgroundColor = UIColor.white
            self.changingNarrativeLabel.textColor = UIColor.black
            
            self.settingsCell.backgroundColor = UIColor.white
            self.settingsLabel.textColor = UIColor.black
            
            self.tableView.separatorStyle = .singleLine
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Reachability.checkInternetReachable() == false {
            
            
            let alert = UIAlertController(title: "No Internet Connection", message: "The Internet connection appears to be offline. Please connect to Wi-Fi or use Cellular Data to continue", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Turn On", style: UIAlertActionStyle.default, handler: { (action) in
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
            
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if(segue.identifier == "showNews") {
            let destination = segue.destination as! PostController
            destination.sectionFrom = "news"
            destination.thisSectionTitle = "News"
        }
        else if(segue.identifier == "showCenterfold") {
            let destination = segue.destination as! PostController
            destination.sectionFrom = "centerfold"
            destination.thisSectionTitle = "Centerfold"
        }
        else if(segue.identifier == "showFeatures") {
            let destination = segue.destination as! PostController
            destination.sectionFrom = "features"
            destination.thisSectionTitle = "Features"
        }
        else if(segue.identifier == "showForum") {
            let destination = segue.destination as! PostController
            destination.sectionFrom = "forum"
            destination.thisSectionTitle = "Forum"
        }
        else if(segue.identifier == "showSports") {
            let destination = segue.destination as! PostController
            destination.sectionFrom = "sports"
            destination.thisSectionTitle = "Sports"
        }
        else if(segue.identifier == "showLifestyle") {
            let destination = segue.destination as! PostController
            destination.sectionFrom = "lifestyle"
            destination.thisSectionTitle = "Lifestyle"
        }
        else if(segue.identifier == "showChanging") {
            let destination = segue.destination as! PostController
            destination.sectionFrom = "changing-the-narrative"
            destination.thisSectionTitle = "Changing the Narrative"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToSections(_ segue: UIStoryboardSegue){
        
    }
    
}

