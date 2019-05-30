//
//  TestFactsDetailViewController.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/29/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit

class TestFactsDetailViewController: UIViewController {

    var selectedRow = Rows()

    lazy var factImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_setImage(with: URL(string: selectedRow.imageUrl ?? ""), placeholderImage: UIImage(named: "noimage.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var factDescriptionLabel: UILabel = {
        let descLabel = UILabel()
        if selectedRow.description == "" || selectedRow.description == nil {
            descLabel.text = "No Content Available"
        } else {
            descLabel.text = selectedRow.description
        }
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = selectedRow.title
        self.setUpView()
    }
    
    // MARK: - Setup the view by setting constraints

    func setUpView() {
        self.view.addSubview(factImageView)
        factImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            factImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            factImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            factImageView.widthAnchor.constraint(equalToConstant: 150),
            factImageView.heightAnchor.constraint(equalToConstant: 150)
            ])
        
        self.view.addSubview(factDescriptionLabel)
        factDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            factDescriptionLabel.topAnchor.constraint(equalTo: factImageView.bottomAnchor, constant: 10),
            factDescriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            factDescriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            factDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
            ])
    }
}
