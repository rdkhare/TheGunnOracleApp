//
//  Settings.swift
//  TheGunnOracle
//
//  Created by Taruna Arora on 9/20/17.
//  Copyright © 2017 RDKhare. All rights reserved.
//

import Foundation
import UIKit


class Settings: UIViewController {
    
    @IBOutlet weak var oracleModeLabel: UILabel!
    @IBOutlet weak var oracleSwitch: UISwitch!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var suggestionsTextView: UITextView!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var igButton: UIButton!
    @IBOutlet var wholeView: UIView!
    @IBOutlet weak var settingsView: UIView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let onColor  = UIColor(red: CGFloat(0.0), green: CGFloat(122.0 / 255.0), blue: CGFloat(1.0), alpha: CGFloat(1.0))
        
        self.darkModeSwitch.onTintColor = onColor
        
        if defaults.value(forKey: "oracleOn") != nil{
            
            print("IN ORACLE HERE")
            let switchON: Bool = defaults.value(forKey: "oracleOn")  as! Bool
            oracleSwitch.isOn = switchON
            
            if(switchON == true) {
                let viewcolor = UIColor(red: CGFloat(167.0/255.0), green: CGFloat(47.0 / 255.0), blue: CGFloat(39.0 / 255.0), alpha: CGFloat(1.0))
                
                let topcolor = UIColor(red: CGFloat(152.0/255.0), green: CGFloat(42.0 / 255.0), blue: CGFloat(34.0 / 255.0), alpha: CGFloat(1.0))
                
                wholeView.backgroundColor = topcolor
                settingsView.backgroundColor = viewcolor
            }
            
        }

        if defaults.value(forKey: "darkOn") != nil{
            print("IN DARK HERE")
            let switchON: Bool = defaults.value(forKey: "darkOn") as! Bool
            
            if(switchON == true) {
                let viewcolor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                
                let topcolor = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(40.0 / 255.0), blue: CGFloat(54.0 / 255.0), alpha: CGFloat(1.0))
                
                wholeView.backgroundColor = topcolor
                settingsView.backgroundColor = viewcolor
            }
            
            darkModeSwitch.isOn = switchON
        }
    }
    
    @IBAction func oracleModeToggled(_ sender: Any) {
        
        if(oracleSwitch.isOn) {
            
            let alertA = UIAlertController(title: "Oracle Mode", message: "In order for oracle mode to be turned on, dark mode must be turned off.", preferredStyle: UIAlertControllerStyle.alert)

            alertA.addAction(UIAlertAction(title: "Turn On.", style: UIAlertActionStyle.default, handler: {(action) in
                
                self.darkModeSwitch.setOn(false, animated: true)
                self.defaults.set(self.oracleSwitch.isOn, forKey: "oracleOn")
                self.defaults.set(self.darkModeSwitch.isOn, forKey: "darkOn")
                
                let viewcolor = UIColor(red: CGFloat(167.0/255.0), green: CGFloat(47.0 / 255.0), blue: CGFloat(39.0 / 255.0), alpha: CGFloat(1.0))
                
                let topcolor = UIColor(red: CGFloat(152.0/255.0), green: CGFloat(42.0 / 255.0), blue: CGFloat(34.0 / 255.0), alpha: CGFloat(1.0))
                
                self.wholeView.backgroundColor = topcolor
                self.settingsView.backgroundColor = viewcolor
                
            }))
            
            alertA.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
                
                self.oracleSwitch.setOn(false, animated: true)
                self.darkModeSwitch.setOn(true, animated: true)
                
                self.defaults.set(self.oracleSwitch.isOn, forKey: "oracleOn")
                self.defaults.set(self.darkModeSwitch.isOn, forKey: "darkOn")
                
                let viewcolor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                
                let topcolor = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(40.0 / 255.0), blue: CGFloat(54.0 / 255.0), alpha: CGFloat(1.0))
                
                self.wholeView.backgroundColor = topcolor
                self.settingsView.backgroundColor = viewcolor
            }))
            
            self.present(alertA, animated: true, completion: nil)
            
        }
        else if(oracleSwitch.isOn == false && darkModeSwitch.isOn == false) {
            
            darkModeSwitch.setOn(true, animated: true)
            defaults.set(oracleSwitch.isOn, forKey: "oracleOn")
            defaults.set(darkModeSwitch.isOn, forKey: "darkOn")
            
            let viewcolor = UIColor(red: CGFloat(167.0/255.0), green: CGFloat(47.0 / 255.0), blue: CGFloat(39.0 / 255.0), alpha: CGFloat(1.0))
            
            let topcolor = UIColor(red: CGFloat(152.0/255.0), green: CGFloat(42.0 / 255.0), blue: CGFloat(34.0 / 255.0), alpha: CGFloat(1.0))
            
            self.wholeView.backgroundColor = topcolor
            self.settingsView.backgroundColor = viewcolor
        }
        
        
    }
    
    @IBAction func darkModeToggled(_ sender: Any) {
        
        if(darkModeSwitch.isOn) {
            
            let alertA = UIAlertController(title: "Dark Mode", message: "In order for dark mode to be turned on, oracle mode must be turned off.", preferredStyle: UIAlertControllerStyle.alert)
            
            alertA.addAction(UIAlertAction(title: "Turn On.", style: UIAlertActionStyle.default, handler: {(action) in
                
                self.oracleSwitch.setOn(false, animated: true)
                self.defaults.set(self.oracleSwitch.isOn, forKey: "oracleOn")
                self.defaults.set(self.darkModeSwitch.isOn, forKey: "darkOn")
                
                let viewcolor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                
                let topcolor = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(40.0 / 255.0), blue: CGFloat(54.0 / 255.0), alpha: CGFloat(1.0))
                
                self.wholeView.backgroundColor = topcolor
                self.settingsView.backgroundColor = viewcolor
                
            }))
            
            alertA.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
                
                self.darkModeSwitch.setOn(false, animated: true)
                self.oracleSwitch.setOn(true, animated: true)
                
                self.defaults.set(self.oracleSwitch.isOn, forKey: "oracleOn")
                self.defaults.set(self.darkModeSwitch.isOn, forKey: "darkOn")
                
                let viewcolor = UIColor(red: CGFloat(167.0/255.0), green: CGFloat(47.0 / 255.0), blue: CGFloat(39.0 / 255.0), alpha: CGFloat(1.0))
                
                let topcolor = UIColor(red: CGFloat(152.0/255.0), green: CGFloat(42.0 / 255.0), blue: CGFloat(34.0 / 255.0), alpha: CGFloat(1.0))
                
                self.wholeView.backgroundColor = topcolor
                self.settingsView.backgroundColor = viewcolor
            }))
            
            self.present(alertA, animated: true, completion: nil)
            
        }
        else if(darkModeSwitch.isOn == false && oracleSwitch.isOn == false) {
            oracleSwitch.setOn(true, animated: true)
            defaults.set(oracleSwitch.isOn, forKey: "oracleOn")
            defaults.set(darkModeSwitch.isOn, forKey: "darkOn")
            
            let viewcolor = UIColor(red: CGFloat(167.0/255.0), green: CGFloat(47.0 / 255.0), blue: CGFloat(39.0 / 255.0), alpha: CGFloat(1.0))
            
            let topcolor = UIColor(red: CGFloat(152.0/255.0), green: CGFloat(42.0 / 255.0), blue: CGFloat(34.0 / 255.0), alpha: CGFloat(1.0))
            
            self.wholeView.backgroundColor = topcolor
            self.settingsView.backgroundColor = viewcolor
        }
        
        
    }
    
    func hideElements() {
        oracleModeLabel.isHidden = true
        oracleSwitch.isHidden = true
        darkModeLabel.isHidden = true
        darkModeSwitch.isHidden = true
    }
    
    func showElements() {
        oracleModeLabel.isHidden = false
        oracleSwitch.isHidden = false
        darkModeLabel.isHidden = false
        darkModeSwitch.isHidden = false
    }
    
    func elementsHidden() -> Bool {
        if(oracleModeLabel.alpha == 0.0 &&
            oracleSwitch.alpha == 0.0 &&
            darkModeLabel.alpha == 0.0 &&
            darkModeSwitch.alpha == 0.0) {
            return true
        }
        else {
            return false
        }
    }
    
    func hideElementsSugg() {
        suggestionsTextView.isHidden = true
    }
    
    func showElementsSugg() {
        suggestionsTextView.isHidden = false
    }
    
    func elementsHiddenSugg() -> Bool {
        if(suggestionsTextView.alpha == 0.0) {
            return true
        }
        else {
            return false
        }
    }
    
    func hideElementsSM() {
        fbButton.isHidden = true
        igButton.isHidden = true
    }
    
    func showElementsSM() {
        fbButton.isHidden = false
        igButton.isHidden = false
    }
    
    func elementsHiddenSM() -> Bool {
        if(fbButton.alpha == 0.0 && igButton.alpha == 0.0) {
            return true
        }
        else {
            return false
        }
    }
    
    @IBAction func suggestionsTouched(_ sender: Any) {
        let top = CGAffineTransform(translationX: 0, y: -40)
        let bottom = CGAffineTransform(translationX: 0, y: 10)
        
        
        if(elementsHiddenSugg() == true){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                
                self.suggestionsTextView.transform = bottom
                
                self.suggestionsTextView.alpha = 1.0
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                
                self.suggestionsTextView.transform = top
                
                self.suggestionsTextView.alpha = 0.0
            }, completion: nil)
            
        }
    }
    @IBAction func SMTouched(_ sender: Any) {
        let top = CGAffineTransform(translationX: 0, y: -40)
        let bottom = CGAffineTransform(translationX: 0, y: 10)
        
        if(elementsHiddenSM() == true){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                
                self.fbButton.transform = bottom
                self.igButton.transform = bottom
                
                self.fbButton.alpha = 1.0
                self.igButton.alpha = 1.0
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                
                self.fbButton.transform = top
                self.igButton.transform = top
                
                self.fbButton.alpha = 0.0
                self.igButton.alpha = 0.0
            }, completion: nil)
            
        }
    }
    @IBAction func IGAction(_ sender: Any) {
    }
    @IBAction func appearanceTouched(_ sender: Any) {
        
        let top = CGAffineTransform(translationX: 0, y: -40)
        let bottom = CGAffineTransform(translationX: 0, y: 10)
        
        
        if(elementsHidden() == true){
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                
                self.oracleSwitch.transform = bottom
                self.oracleModeLabel.transform = bottom
                self.darkModeLabel.transform = bottom
                self.darkModeSwitch.transform = bottom
                
                self.oracleSwitch.alpha = 1.0
                self.oracleModeLabel.alpha = 1.0
                self.darkModeLabel.alpha = 1.0
                self.darkModeSwitch.alpha = 1.0
            }, completion: nil)
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations: {
                
                self.oracleSwitch.transform = top
                self.oracleModeLabel.transform = top
                self.darkModeLabel.transform = top
                self.darkModeSwitch.transform = top
                
                self.oracleSwitch.alpha = 0.0
                self.oracleModeLabel.alpha = 0.0
                self.darkModeLabel.alpha = 0.0
                self.darkModeSwitch.alpha = 0.0
            }, completion: nil)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        
    }
    
    
}
