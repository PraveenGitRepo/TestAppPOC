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

let factsEndPoint: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

class FactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var rowsArray: [[String: AnyObject]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        self.getFactsListData { (jsonObject) in
            self.updateUI(result: jsonObject)
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    func getFactsListData(completionHandler: @escaping ([String: AnyObject]) -> Void) {
        AF.request(factsEndPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString
            { response in
                switch response.result
                {
                case .failure(let error):
                    if let data = response.data {
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    print(error)
                case .success(let jsonResponse):
                    let jsonData = jsonResponse.data(using: .utf8)!
                    if let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) {
                        completionHandler(dictionary as? [String: AnyObject] ?? NSDictionary() as! [String : AnyObject])
                    }
                }
        }
    }
    
    func updateUI(result: [String: AnyObject]) {
        if let navigationTitleText = result["title"] as? String {
            self.navigationItem.title = navigationTitleText
        }
        
        if let rowsArrayObject = result["rows"] as? [[String: AnyObject]] {
            rowsArray = rowsArrayObject
        }
        tableView.reloadData()
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

extension FactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return rowsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FactsListTableViewCell
        
        let row = rowsArray[indexPath.row]
        cell.titleLabel.text = row["title"] as? String ?? ""
        cell.descriptionLabel.text = row["description"] as? String ?? ""
        cell.factImageView.sd_setImage(with: URL(string: row["imageHref"] as? String ?? ""), placeholderImage: UIImage(named: "noimage.png"))

        cell.selectionStyle = .none
        return cell
    }
}

