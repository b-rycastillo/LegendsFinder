//
//  StatsViewController.swift
//  LegendsFinder
//
//  Created by Bryan Castillo
//  Copyright © 2019 CastleUnited. All rights reserved.
//

import Foundation
import UIKit

class StatsViewController : UIViewController {
    
    @IBOutlet weak var countrylbl: UILabel!
    
    @IBOutlet weak var flagimg: UIImageView!
    
    @IBOutlet weak var goalslbl: UILabel!
    
    @IBOutlet weak var wclbl: UILabel!
    
    @IBOutlet weak var clslbl: UILabel!
    
    @IBOutlet weak var uefaslbl: UILabel!
    
    @IBOutlet weak var leagueslbl: UILabel!
    
    @IBOutlet weak var buttonlbl: UIButton!
    
    @IBAction func btn_watch(_ sender: Any) {
        let app = UIApplication.shared
        let urlAddress = String(subLegends.gamelink)
        let urlw = URL(string:urlAddress)
        app.openURL(urlw!)
    }
    
    func extractImage(named:String) -> UIImage {
        let uri = URL(string: named)
        let dataBytes = try? Data(contentsOf: uri!)
        let img = UIImage(data: dataBytes!)
        return img!
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        flagimg.image = extractImage(named: subLegends.country)
        countrylbl.text = subLegends.nationality
        goalslbl.text = String(subLegends.goals)
        wclbl.text = String(subLegends.wc)
        clslbl.text = String(subLegends.cl)
        uefaslbl.text = String(subLegends.uefas)
        leagueslbl.text = String(subLegends.leagues)
    }
    
    var subLegends:LegendsFinder = LegendsFinder()
}
