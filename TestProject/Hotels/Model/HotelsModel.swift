//
//  HotelsModel.swift
//  TestProject
//
//  Created by Ritik Sharma on 28/12/22.
//

import Foundation
class MyHotel:Decodable{
    var imgUrl:String?
    var name:String?
    var originalPrice:String?
    var discountedPrice:String?
    var starRating:String?
}
class HotelsList:Decodable{
    var title:String?
    var cityName:String?
    var noOfHotels:String?
    var viewAllCtaTitle:String?
    var hotelsList: [MyHotel]?
}
class HotelsModel:Decodable{
    var noOfCities:Int?
    var title:String?
    var countryHotels:[HotelsList]?
}
