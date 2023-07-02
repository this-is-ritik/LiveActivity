//
//  HotelsTableViewCell.swift
//  TestProject
//
//  Created by Ritik Sharma on 28/12/22.
//

import UIKit
import SwiftUI

class HotelsTableViewCell: UITableViewCell {

    public static let reuseIdentifier: String = "HotelsTableViewCell"
    
    @IBOutlet var collectionView: UICollectionView!
    private var hotelsList:HotelsList? = nil
 
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        self.registerCells()
//    }

    
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
    }
    func setUpCollectionView(){
//        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width)/2, height: 200)
        self.registerCells()
        self.collectionView.isPagingEnabled = false
    }
    func registerCells(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: HotelCollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: HotelCollectionViewCell.reuseIdentifier)
//        collectionView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 255, alpha: 0.1)
    }
    func configure(hotelsList:HotelsList?){
        if let hotelsList = hotelsList {
            self.hotelsList = hotelsList
        }
        
    }
}

extension HotelsTableViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: 400, height: 250)
        }
}

extension HotelsTableViewCell:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hotelsList?.hotelsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelCollectionViewCell.reuseIdentifier, for: indexPath) as? HotelCollectionViewCell{
            
            if let hotelsForCities = self.hotelsList,let hotelsList = hotelsForCities.hotelsList{
                let index = (hotelsList.index(0, offsetBy: indexPath.row))
                cell.configure(myHotel: hotelsList[index])
                cell.layer.cornerRadius = 8
                cell.sizeToFit()
            }
            
            return cell
        }
        let cell = UICollectionViewCell()
//        cell.addSubview(UIHostingController(rootView:HotelView()))
        
        return cell
    }
}
