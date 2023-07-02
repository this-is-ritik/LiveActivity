//
//  ViewController.swift
//  TestProject
//
//  Created by Ritik Sharma on 28/12/22.
//

import UIKit
import SwiftUI
class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var hotelsDataModel:HotelsModel?
    private var draggableView: DraggableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                         selector: #selector(self.onCellTapped),
                                         name: .init(rawValue: "goToMyHotel"),
                                           object: nil)
        self.title = hotelsDataModel?.title ?? "HotelsApp"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        let nib = UINib(nibName: HotelsTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HotelsTableViewCell.reuseIdentifier)
        self.draggableView = DraggableView()
        if let imgView = self.draggableView?.viewWithTag(2) as? UIImageView{
            imgView.image = UIImage(named: "beach")!
            imgView.highlightedImage = UIImage(named:"mountain")!
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let height = UIScreen.main.bounds.height
        
        self.draggableView?.center = CGPoint(x: 10, y: height - 10 - (self.draggableView?.frame.height ?? 150))
        self.draggableView?.backgroundColor = .red
        self.draggableView?.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.draggableView?.layer.borderWidth = 3
        self.draggableView?.layer.cornerRadius = (self.draggableView?.frame.width ?? 100)/2

        self.draggableView?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveFloatingView)))
//        print(self.draggableView?.frame)
        self.view.bringSubviewToFront(self.draggableView ?? UIView())
        
        /*
         a  b  1
         c  d  1
         tx ty 1
         */
        
        // To move a view without uiview.animate
        // setting tx & ty value in x & y
        // 1
//        floatingView.transform = floatingView.transform.translatedBy(x: 100, y: -200)
        // 2
//        floatingView.transform = CGAffineTransform(translationX: 100, y: -200)
        
        // To scale a view to half the size
        // setting a & d value in x & y
        // 1
//        floatingView.transform = floatingView.transform.scaledBy(x: 0.5, y: 0.5)
        // 2
//        floatingView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        
        
        
        
        
        
        // To rotate a view by an angle
        // setting theta in matrix
        // 1
//        floatingView.transform = floatingView.transform.rotated(by: CGFloat.pi * (45 / 180))
        // 2
//        floatingView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * (225 / 180))
        
//        UIView.animate(withDuration: 1, delay: 1,options: [.preferredFramesPerSecond60,.curveEaseIn,.curveEaseOut], animations: {
//            let angle = CGFloat.pi * 2
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5){
//                self.draggableView?.transform = CGAffineTransform(cos(angle), sin(angle), -sin(angle), cos(angle), 0, 0)
//            }
////            floatingView.transform.a =
////            floatingView.transform.b =
////            floatingView.transform.c =
////            floatingView.transform.d =
//        })
    }
    @objc func onCellTapped(notification:Notification){
        let myHotel:MyHotel? = notification.userInfo?["MyHotel"] as? MyHotel
        let viewController = UIHostingController(rootView: MyHotelView(myHotel: myHotel))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func moveFloatingView(gesture : UIPanGestureRecognizer){
        let location = gesture.location(in: self.view)
        gesture.view?.center = location
        if gesture.state == .ended{
            
            let width = gesture.view?.frame.width ?? 0
            let height = gesture.view?.frame.height ?? 0
            // right side to left movement in X
            if (gesture.view?.frame.midX ?? 0) + width / 2 >= UIScreen.main.bounds.width{
                UIView.animate(withDuration: 1, delay: 0,options: .allowAnimatedContent){
                    gesture.view?.center.x = UIScreen.main.bounds.width -  width / 2
                }
            }
            // left side to right side movement in X
            if (gesture.view?.frame.midX ?? 0) - width / 2 < 0{
                UIView.animate(withDuration: 1, delay: 0,options: .allowAnimatedContent){
                    gesture.view?.center.x = width / 2
                }
            }
            
            // down to up movement in Y
            if (gesture.view?.frame.midY ?? 0) + height / 2 >= UIScreen.main.bounds.height{
                UIView.animate(withDuration: 1, delay: 0,options: .allowAnimatedContent){
                    gesture.view?.center.y = UIScreen.main.bounds.height - height / 2
                }
            }
            // up to down movement in Y
            if (gesture.view?.frame.midY ?? 0) - height / 2 < 0{
                UIView.animate(withDuration: 1, delay: 0,options: .allowAnimatedContent){
                    gesture.view?.center.y = height / 2
                }
            }
        }
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
extension ViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return hotelsDataModel?.noOfCities ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: HotelsTableViewCell.reuseIdentifier, for: indexPath) as! HotelsTableViewCell
            if let hotelsDataModel = self.hotelsDataModel,let countryHotels = hotelsDataModel.countryHotels{
                let index = (countryHotels.index(0, offsetBy: indexPath.section))
                print("blablablablabla")
                print(indexPath.section,indexPath.row)
                print(countryHotels[index].hotelsList?.count)
                cell.configure(hotelsList: countryHotels[index])
            }
        cell.backgroundColor = UIColor.clear
            return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let hotelsDataModel = self.hotelsDataModel,let countryHotels = hotelsDataModel.countryHotels{
            return "\(countryHotels[section].title!) \(countryHotels[section].cityName!)"
        }
        return "Unknown City"
    }
}

