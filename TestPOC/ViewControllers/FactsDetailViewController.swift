//
//  FactsDetailViewController.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/22/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class FactsDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var factImageView: UIImageView!
    var selectedRow = Rows()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = selectedRow.title ?? ""
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    
    // MARK: - Update the detail view UI
    func updateUI() {
        self.descriptionLabel.text = selectedRow.description ?? "No content available"
        self.factImageView.sd_setImage(with: URL(string: selectedRow.imageUrl ?? ""), placeholderImage: UIImage(named: "noimage.png"))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

