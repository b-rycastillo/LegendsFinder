//
//  MasterViewController.swift
//  LegendsFinder
//
//  Created by Bryan Castillo
//  Copyright © 2019 CastleUnited. All rights reserved.
// https://api.myjson.com/bins/15lkdo

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var detailViewController: DetailViewController? = nil
    var LFArray = [LegendsFinder]()

    
    
    
    func prepareJASONData(){
        
        //1. find url. create url from string
        //add security transport layer override on the info.plist file
        
        let endPoint = "https://api.myjson.com/bins/15lkdo"
        
        let isURL:URL = URL(string: endPoint)!
        
        //2.use data function to retrieve the data
        
        let jsonUrlData = try? Data (contentsOf: isURL)
        
        print(jsonUrlData ?? "Error: No data to print. JSONURLData is Nil")
        //3. take returned data and build dictionary object
        
        if(jsonUrlData != nil){
            
            let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with:jsonUrlData!, options:JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            print(dictionary)
            
            //4. take dictionary object and create an entity  EventFinder Object
            
            let lfDictionary = dictionary["legends"]! as![[String:AnyObject]]
            
            for index in 0...lfDictionary.count - 1{
                
                let singleLF = lfDictionary[index]
                let lf = LegendsFinder()
                lf.description = singleLF["description"] as! String
                lf.dob = singleLF["dob"] as! String
                lf.name = singleLF["name"] as! String
                lf.id = singleLF["id"] as! Int
                lf.nationality = singleLF["nationality"] as! String
                lf.wc = singleLF["wc"] as! Int
                lf.cl = singleLF["cl"] as! Int
                lf.uefas = singleLF["uefas"] as! Int
                lf.goals = singleLF["goals"] as! Int
                lf.leagues = singleLF["leagues"] as! Int
                lf.image = singleLF["image"] as! String
                lf.country = singleLF["country"] as! String
                lf.model = singleLF["model"] as! String
                lf.gamelink = singleLF["gamelink"] as! String
                //5. Add event finder to the array
                LFArray.append(lf)
            }
        }
    }
    
    func extractImage(named:String) -> UIImage {
        let uri = URL(string: named)
        let dataBytes = try? Data(contentsOf: uri!)
        let img = UIImage(data: dataBytes!)
        return img!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        
        navigationItem.leftBarButtonItem = editButtonItem
        prepareJASONData()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedLegend = LFArray[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = selectedLegend
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LFArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let selectedLegend = LFArray[indexPath.row]
        cell.textLabel!.text = selectedLegend.name
        cell.detailTextLabel!.text = selectedLegend.nationality
        
        var img:UIImage = extractImage(named:selectedLegend.image)
        cell.imageView?.image = img
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           LFArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
       }
    }


}

