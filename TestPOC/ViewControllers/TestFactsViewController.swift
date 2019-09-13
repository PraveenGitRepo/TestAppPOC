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
            
            guard let data = jsonObject else { return }
            do {
                let decoder = JSONDecoder()
                let objects = try decoder.decode(Facts.self, from: data)
                self.updateUI(result: objects)

            } catch let err {
            }
        }
    }
    

    // MARK: - Update the UI on success of api call
    
    func updateUI(result: Facts) {
        self.title = result.title
        
        // Save json object to data model class
        rowsArray = result.rows
        factsTableView.reloadData()
    }
    
    func setUpTableview() {
        
        factsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(factsTableView)

        factsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        factsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        factsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1.0).isActive = true
        factsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5.0).isActive = true

        factsTableView.dataSource = self
        factsTableView.delegate = self
        factsTableView.register(TestFacstsTableViewCell.self, forCellReuseIdentifier: "Cell")
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
        let row = rowsArray[indexPath.row]
        cell.row = row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = TestFactsDetailViewController()
        detailVC.selectedRow = rowsArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: false)
    }
}
