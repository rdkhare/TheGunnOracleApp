//
//  PostController.swift
//  TheGunnOracle
//
//  Created by Taruna Arora on 9/13/17.
//  Copyright © 2017 RDKhare. All rights reserved.
//

import Foundation
import UIKit
import Kanna
import Alamofire

class PostController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var postsTitles: [String] = []
    var postsTimes: [String] = []
    var imageURLs: [String] = []
    let postCell = "postCell"
    var sectionFrom = ""
    var thisSectionTitle: String?
    var articleURLs: [String] = []
    
    var filteredData: [String]!
    
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet var wholeview: UIView!
    
    let defaults = UserDefaults.standard
    
    var myIndicator : UIActivityIndicatorView = UIActivityIndicatorView (activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionTitle.text = self.thisSectionTitle//sets the title of the page to the sections
        
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        self.postTableView.addSubview(refreshControl) // not required when using UITableViewController
        
        myIndicator = UIActivityIndicatorView(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 100, height: 100))
        myIndicator.activityIndicatorViewStyle = .gray
        myIndicator.center = self.view.center
        self.view.addSubview(myIndicator)
        myIndicator.bringSubview(toFront: self.view)
        myIndicator.startAnimating()
        
        sectionTitle.adjustsFontSizeToFitWidth = true
        
        if defaults.value(forKey: "darkOn") != nil{  // Dark Mode stuff
            if((defaults.value(forKey: "darkOn") as! Bool) == true) {  // check if dark mode is on
                
                //sets the colors of elements
                
                self.postTableView.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                self.sectionTitle.textColor = UIColor.white
                refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...", attributes: [NSForegroundColorAttributeName : UIColor.white])
                self.sectionView.backgroundColor = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(40.0 / 255.0), blue: CGFloat(54.0 / 255.0), alpha: CGFloat(1.0))
                self.wholeview.backgroundColor = UIColor(red: CGFloat(27.0/255.0), green: CGFloat(40.0 / 255.0), blue: CGFloat(54.0 / 255.0), alpha: CGFloat(1.0))
                
            }
        }
        
        self.scrapeOracleHTML()  // executes the scrapeOracleHTML function which basically parses the website.
    }
    
    func refresh(sender:AnyObject) {
        self.postTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func noConnection() {
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.textColor = UIColor.black
        emptyLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightThin)
        emptyLabel.textAlignment = NSTextAlignment.center
        emptyLabel.center = self.view.center
        emptyLabel.text = "No Internet Connection."
        
        postTableView.backgroundView = emptyLabel
        postTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Reachability.checkInternetReachable() == false {
            
            self.myIndicator.stopAnimating()
            self.myIndicator.hidesWhenStopped = true
            
            let alert = UIAlertController(title: "No Internet Connection", message: "The Internet connection appears to be offline. Please connect to Wi-Fi or use Cellular Data to continue", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Turn On", style: UIAlertActionStyle.default, handler: { (action) in
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
            }))
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
            
            self.noConnection()
            self.postTableView.separatorStyle = .none
            self.postTableView.reloadData()
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: postCell, for: indexPath) as! PostCell
        
        let row = indexPath.row
        
        cell.postTitle.text = postsTitles[row]
        cell.postTime.text = postsTimes[row]
        
        if defaults.value(forKey: "darkOn") != nil{
            if((defaults.value(forKey: "darkOn") as! Bool) == true) {
                
                cell.postTitle.textColor = UIColor.white
                cell.backgroundColor = UIColor(red: CGFloat(44.0/255.0), green: CGFloat(65.0 / 255.0), blue: CGFloat(88.0 / 255.0), alpha: CGFloat(1.0))
                cell.postTime.textColor = UIColor.lightGray
                
            }
        }
        
        downloadImage(url: URL(string: self.imageURLs[row])!, imageView: cell.imagePost)//sets the images for the articles
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsTitles.count
    }
    
    func scrapeOracleHTML() -> Void {//executes the parseHTML function for the corresponding section
        Alamofire.request("http://gunnoracle.com/category/\(sectionFrom)").responseString { response in
            print("\(response.result.isSuccess)")
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if(segue.identifier == "showArticle") {
            let destination = segue.destination as! ArticleView

            let title = postsTitles[(self.postTableView.indexPathForSelectedRow?.row)!]
            let imageURL = imageURLs[(self.postTableView.indexPathForSelectedRow?.row)!]
            let articleURL = articleURLs[(self.postTableView.indexPathForSelectedRow?.row)!]
            
            destination.titleOfArticle = title
            destination.imageURL = imageURL
            destination.articleURL = articleURL
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {  // gets the image data from the url
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, imageView: UIImageView) {  // downloads the image from the url and converts it
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func unwindToPostController(_ segue: UIStoryboardSegue){
        
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        // When there is no text, filteredData is the same as the original data
//        // When user has entered text into the search box
//        // Use the filter method to iterate over all items in the data array
//        // For each item, return true if the item should be included and false if the
//        // item should NOT be included
//        filteredData = searchText.isEmpty ? postsTitles : postsTitles.filter({(dataString: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return dataString.range(of: searchText, options: .caseInsensitive) != nil
//        })
//        
//        postTableView.reloadData()
//    }
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            for post in doc.css("h3[class^='loop-title']") {  // gets the post titles directory
                
                let showString = post.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)  // post title text by itself
                
                postsTitles.append(showString)  // appends the post title text to an array of post titles
            }
            
            for postTime in doc.css("p[class^='meta']") {  // gets the date that the article was written
                let postTimeString = postTime.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)  // gets the text by itself
                
                postsTimes.append(postTimeString)  // appends the post times to an array
            }
            
            for item in doc.xpath("//div[@class='loop-thumb']/a") {  // goes through the xpath and looks at the directories for each one that matches
                
                let imageURL = (item.at_xpath("img")?["src"])  // gets the image source
                
                if(imageURL! == "https://s0.wp.com/wp-content/themes/premium/mh-magazine/images/noimage_174x131.png"){  // checks if no image, and replaces with The Oracle placeholder image
                    self.imageURLs.append("https://scontent.fsnc1-1.fna.fbcdn.net/v/t1.0-9/12002228_10153530981476668_4060049645901806384_n.jpg?oh=daf19a8eaf94db01fddd0516e25146f8&oe=5A4F5E34")  // appends placeholder image for each article with no image
                }
                else {
                    self.imageURLs.append(imageURL!)  // appends the image URL to the array of image urls
                }
            }
            
            for item in doc.xpath("//h3[@class='loop-title']"){
                let articleURL = (item.at_xpath("a")?["href"])
                
                self.articleURLs.append(articleURL!)
            }
            
        }
        filteredData = postsTitles
        self.myIndicator.stopAnimating()
        self.myIndicator.hidesWhenStopped = true
        self.postTableView.reloadData()  // reloads the tableview's data after everything is done.
    }
    
}
