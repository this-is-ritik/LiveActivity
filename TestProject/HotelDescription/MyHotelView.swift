//
//  MyHotelView.swift
//  TestProject
//
//  Created by Ritik Sharma on 06/01/23.
//

import SwiftUI

struct MyHotelView: View {
    var myHotel:MyHotel?
    var body: some View {
        NavigationView{
            VStack{
                AsyncImage(url: URL(string: (self.myHotel?.imgUrl!)!))
                    .background(in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .cornerRadius(10,antialiased: true)
                    .aspectRatio(contentMode: .fit)
                HStack{
                    Text(myHotel?.name ?? "Hotel Name")
                        .bold()
                        .font(.title3)
                    Spacer()
                    Text("₹")
                        .font(.title3)
                    Text(myHotel?.discountedPrice ?? "nil")
                        .font(.title3)
                }
                .background(in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                HStack{
                    ForEach(0..<(Int(myHotel?.starRating ?? "0") ?? 0)){ _ in
                        Text("★")
                            .foregroundColor(.green)
                    }
                    Spacer()
                    Text("₹")
                    Text(myHotel?.originalPrice ?? "nil")
                        .foregroundColor(.black)
                        .strikethrough(true, color: .red)
                }
                .background(in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                HStack{
                    Button("Book Now"){
                        
                    }
                    .frame(maxWidth:.infinity)
                    .foregroundColor(.blue)
                    .background(Color(uiColor: UIColor.cyan))
                }
                .background(in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .background(in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            .cornerRadius(10,antialiased: true)
        }
        .navigationTitle("Hotel")
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
    }
}
struct MyHotelView_Previews: PreviewProvider {
    static var previews: some View {
        MyHotelView()
    }
}
