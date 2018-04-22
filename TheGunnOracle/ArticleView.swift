//
//  ArticleView.swift
//  TheGunnOracle
//
//  Created by Taruna Arora on 9/16/17.
//  Copyright © 2017 RDKhare. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Kanna


class ArticleView: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    var imageURL: String?
    var titleOfArticle: String?
    var articleURL: String?
    var bodyText: String? = ""
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTextView.textContainerInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        downloadImage(url: URL(string: imageURL!)!, imageView: articleImage)
        articleTitle.text = titleOfArticle
        articleTextView.delegate = self
        
        if defaults.value(forKey: "darkOn") != nil{ // Dark Mode stuff
            if((defaults.value(forKey: "darkOn") as! Bool) == true) { //check if dark mode is on
                
                //sets the colors of elements
                
                self.articleTextView.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.view.backgroundColor = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(40.0 / 255.0), blue: CGFloat(54.0 / 255.0), alpha: CGFloat(1.0))
                self.articleTextView.textColor = UIColor.white
            }
        }
        
        self.scrapeOracleHTML()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenSize = UIScreen.main.bounds
        //let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        if(scrollView.contentOffset.y > 0) {
            
            UIView.animate(withDuration: 0.4, animations: {
                
                self.articleTextView.frame = CGRect(x: Int(self.articleTextView.frame.origin.x), y: 0, width: Int(self.articleTextView.frame.size.width), height: Int(screenHeight))
                
            })

            self.backButton.isHidden = true
            self.articleImage.isHidden = true
        }
        if(scrollView.contentOffset.y <= 0) {
            UIView.animate(withDuration: 0.4, animations: {
                
                self.articleTextView.frame = CGRect(x: Int(self.articleTextView.frame.origin.x), y: 375, width: Int(self.articleTextView.frame.size.width), height: Int(292))
                
            })
            
            self.backButton.isHidden = false
            self.articleImage.isHidden = false
        }
    }
    
    func parseHTML(html: String) -> Void {
        
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            for thisText in doc.xpath("//div[@class='column']/p"){
                let paragraph = thisText.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                bodyText = bodyText! +  "\n \n\(paragraph)"
            }
            articleTextView.text = bodyText! + "\n"
            if(articleTextView.text.isEmpty || articleTextView.text == "\n") {
                for newText in doc.xpath("//div[@class='entry clearfix']/p") {
                    let paragraph = newText.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    bodyText = bodyText! +  "\n \n\(paragraph)"
                }
                articleTextView.text = bodyText! + "\n"
            }
        }
        
    }
    
    func scrapeOracleHTML() -> Void {//executes the parseHTML function for the corresponding section
        Alamofire.request(articleURL!).responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {//gets the image data from the url
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, imageView: UIImageView) {//downloads the image from the url and converts it
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                imageView.image = UIImage(data: data)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
