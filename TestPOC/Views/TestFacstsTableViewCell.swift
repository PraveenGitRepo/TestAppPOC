//
//  TestFacstsTableViewCell.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/29/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit
import SDWebImage

class TestFacstsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var row : Rows? {
        didSet {
            factsNameLabel.text = row?.title
            factsDescriptionLabel.text = row?.description
            factImage.sd_setImage(with: URL(string: row?.imageUrl ?? ""), placeholderImage: UIImage(named: "noimage.png"))
        }
    }

    private let factsNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let factsDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let factImage : UIImageView = {
        let imgView = UIImageView(image: UIImage())
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    // MARK: - Configure the cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(factImage)
        addSubview(factsNameLabel)
        addSubview(factsDescriptionLabel)

        
        factImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 90, enableInsets: false)
        factsNameLabel.anchor(top: topAnchor, left: factImage.rightAnchor, bottom: factsDescriptionLabel.topAnchor, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width - 10, height: 0, enableInsets: false)
        factsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            factsDescriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            factsDescriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            factsDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            factsDescriptionLabel.topAnchor.constraint(equalTo: factImage.bottomAnchor, constant: 2),
            factsDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
