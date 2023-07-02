//
//  TrainDropOffTableViewCell.swift
//  TestProject
//
//  Created by Ritik Sharma on 28/12/22.
//

import UIKit

class : UITableViewCell {
    static var reuseIdentifier = "TrainDropOffTableViewCell"
    @IBOutlet var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        print(self.reuseIdentifier)
        collectionView.register(, forCellWithReuseIdentifier: <#T##String#>)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
