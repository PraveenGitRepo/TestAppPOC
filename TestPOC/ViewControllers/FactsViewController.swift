//
//  FactsViewController.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/22/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import PKHUD

let factsEndPoint: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
public typealias ResponseCompletionHandler = (_ error: NSError?, _ responseJSON: NSDictionary?) -> (Void)

class FactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //var rowsArray: [[String: AnyObject]] = [[:]]
    var rowsArray = [Rows]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        
        //Call Facts List api
        self.getFactsListData { (error, jsonObject)  in
            PKHUD.sharedHUD.hide()
            if let object = jsonObject as? [String: AnyObject] {
                self.updateUI(result: object)
            }
        }
    }
    // MARK: - GET api call using Alamofire library
    
    func getFactsListData(completion: @escaping ResponseCompletionHandler) {
        HUD.show(.progress)
        AF.request(factsEndPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString
            { response in
                switch response.result
                {
                case .failure(let error):
                    if let data = response.data {
                        HUD.show(.error)
                        completion(error as NSError, nil)
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    print(error)
                case .success(let jsonResponse):
                    HUD.show(.success)
                    let jsonData = jsonResponse.data(using: .utf8)!
                    if let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) {
                        completion(nil, dictionary as? NSDictionary ?? NSDictionary())
                    }
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
        tableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? FactsDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedRow = rowsArray[indexPath.row]
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* removing "Back" text on navigation left bar button item */
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension FactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return rowsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FactsListTableViewCell
        let row = rowsArray[indexPath.row]
        cell.titleLabel.text = row.title ?? ""
        cell.descriptionLabel.text = row.description ?? ""
        cell.factImageView.sd_setImage(with: URL(string: row.imageUrl ?? ""), placeholderImage: UIImage(named: "noimage.png"))
        cell.selectionStyle = .none
        return cell
    }
}

