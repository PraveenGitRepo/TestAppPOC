//
//  TestFactsViewController.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/29/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit
import PKHUD

class TestFactsViewController: UIViewController {

    var factsTableView = UITableView()
    var rowsArray = [Rows]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUpTableview()
        
        //Call Facts List api
        RequestManager.shared.getFactsListData(controller: self, endPointUrl: factsEndPoint) { (error, jsonObject) -> (Void) in
            PKHUD.sharedHUD.hide()
            if let object = jsonObject as? [String: AnyObject] {
               self.updateUI(result: object)
            }
        }
    }
    

    // MARK: - Update the UI on success of api call
    
    func updateUI(result: [String: AnyObject]) {
        if let navigationTitleText = result["title"] as? String {
            self.navigationItem.title = navigationTitleText
        }
        
        // Save json object to data model class
        let facts = Facts.addFacts(jsonObject: result)
        rowsArray = facts[0].rows
        factsTableView.reloadData()
    }
    
    func setUpTableview() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        factsTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        factsTableView.dataSource = self
        factsTableView.delegate = self
        factsTableView.register(TestFacstsTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(factsTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        factsTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* removing "Back" text on navigation left bar button item */
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension TestFactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TestFacstsTableViewCell
        if rowsArray.count > 0 {
            let row = rowsArray[indexPath.row]
            cell.row = row
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = TestFactsDetailViewController()
        detailVC.selectedRow = rowsArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
}
