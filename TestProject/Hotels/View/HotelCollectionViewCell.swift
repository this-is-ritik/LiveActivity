//
//  HotelCollectionViewCell.swift
//  TestProject
//
//  Created by Ritik Sharma on 28/12/22.
//

import UIKit
import SwiftUI

class HotelCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier = "HotelCollectionViewCell"
    private var myHotel:MyHotel? = nil
    @IBOutlet var hotelImage: UIImageView!
    @IBOutlet var starRating: UILabel!
    
    @IBOutlet var hotelName: UILabel!
    
    @IBOutlet var originalPrice: UILabel!
    
    @IBOutlet var discountedPrice: UILabel!
    
    
    @IBOutlet var bookingBtn: UIButton!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func loadHotels(){
        self.bookingBtn.layer.cornerRadius = 10
//        DispatchQueue.main.async {
            if let myHotel = self.myHotel {
                var starRatingStr = ""
                let noOfStars = Int(myHotel.starRating ?? "1") ?? 1
                for _ in 0..<noOfStars{
                    starRatingStr+="★"
                }
                let attributesForRating = [NSAttributedString.Key.foregroundColor : UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)]
                let attributedStarStr = NSAttributedString(string: starRatingStr,attributes: attributesForRating)
                self.hotelName.text = myHotel.name ?? ""
                
                let ogPriceStr = (myHotel.originalPrice ?? "0")
                let attributesForOgPrice = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.foregroundColor : UIColor(red: 0, green: 0, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
                let ogPriceAttributedStr = NSMutableAttributedString(string: "₹ ")
                ogPriceAttributedStr.append(NSAttributedString(string: ogPriceStr,attributes: attributesForOgPrice))
                self.originalPrice.attributedText = ogPriceAttributedStr
                
                
                let discountedPriceStr = (myHotel.discountedPrice ?? "0")
                let attributesForDiscountedPrice = [NSAttributedString.Key.foregroundColor : UIColor(red: 0, green: 0, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
                let discountedPriceAttributedStr = NSMutableAttributedString(string: "₹ ")
                discountedPriceAttributedStr.append(NSAttributedString(string: discountedPriceStr,attributes: attributesForDiscountedPrice))
                self.discountedPrice.attributedText = discountedPriceAttributedStr
                
                self.starRating.attributedText = attributedStarStr
                self.getImageFromUrl(url:URL.init(string: myHotel.imgUrl ?? "")!)
                self.bookingBtn.tintColor = UIColor.init(white: 255, alpha: 1)
                self.bookingBtn.backgroundColor = UIColor.init(red: 0, green: 0, blue: 255, alpha: 0.3)
            }
//        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//    gets called while scrolling and set values according to mentioned code
    func configure(myHotel:MyHotel?){
        if let myHotel = myHotel {
            self.myHotel = myHotel
        }
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.masksToBounds = false
        
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.cornerRadius = 10
//        self.layer.shadowColor = CGColor(gray: 1, alpha: 0.5)
//        self.layer.shadowRadius = 20
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.loadHotels()
    }
    func getImageFromUrl(url: URL){
        ImageCacheManager.shared.loadImageFrom(url: url, success: {
            image in
            if let image{
                DispatchQueue.main.async {
                    self.hotelImage.image = image
                }
            }
        }, failure: {
            DispatchQueue.main.async {
                self.hotelImage.image = nil
            }
        })
    }
    @IBAction func bookNowTapped(_ sender: Any) {
        var hotelInfo:[String: Any] = [String: Any]()
        hotelInfo["MyHotel"] = self.myHotel
        NotificationCenter.default.post(name: .init("goToMyHotel"), object: self,userInfo: hotelInfo)
    }
    
    
}
