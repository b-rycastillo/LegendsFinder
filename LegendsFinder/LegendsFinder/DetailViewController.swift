//
//  DetailViewController.swift
//  LegendsFinder
//
//  Created by Bryan Castillo
//  Copyright © 2019 CastleUnited. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    
    @IBOutlet weak var modelImage: UIImageView!

    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var countrylbl: UILabel!
    @IBOutlet weak var doblbl: UILabel!
    @IBOutlet weak var desclbl: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.name
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
        configureView()
        modelImage.image = extractImage(named: detailItem!.model)
        desclbl.text = detailItem?.description
        countrylbl.text = detailItem?.nationality
        doblbl.text = detailItem?.dob
        namelbl.text = detailItem?.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statsSegue"{
            let controller = segue.destination as! StatsViewController
            
            controller.subLegends = detailItem!
        }
    }

    var detailItem: LegendsFinder? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

