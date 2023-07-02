//
//  MyViewController.swift
//  TestProject
//
//  Created by Ritik Sharma on 28/12/22.
//

import UIKit
import SwiftUI
import ActivityKit


class MyViewController: UIViewController {

    var hotelsDataModel:HotelsModel?
    let apiUrl = "https://demo4627632.mockable.io/hotelslistfromapi"
    
    @IBOutlet var swiftUiView: UIButton!
    @IBOutlet var hotelsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hotelsButton.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    @IBAction func openHotelTapped(_ sender: Any) {
        self.fetchResponse(){
            model in
            self.hotelsDataModel = model
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier:
                                    "GoToHotelSegue", sender: self)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ViewController{
            dest.hotelsDataModel = self.hotelsDataModel
        }
    }
    
    func fetchResponse(completion:@escaping (_ model:HotelsModel)->()){
        URLSession.shared.dataTask(with: URL(string:self.apiUrl)!){data,response,error in
            if let data = data{
                do{
                    let jsonDecoder = JSONDecoder()
                    let statement = try jsonDecoder.decode(HotelsModel.self, from:data)
                    completion(statement)
                }
                catch DecodingError.dataCorrupted(let context) {
                   print(context)
               } catch DecodingError.keyNotFound(let key, let context) {
                   print("Key '\(key)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch DecodingError.valueNotFound(let value, let context) {
                   print("Value '\(value)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch DecodingError.typeMismatch(let type, let context) {
                   print("Type '\(type)' mismatch:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch {
                   print("error: ", error)
               }
            }
        }.resume()
    }
    
    @IBAction func openSwiftUiView(_ sender: Any) {
//        let hotelView = UIHostingController(rootView: nil)
//        self.navigationController?.pushViewController(hotelView, animated: false)
    }
    
    
    @IBAction func startActivity(_ sender: Any) {
        if #available(iOS 16.2, *) {
            Task {
                let attr = MMTWidgetExtensionAttributes(name: "LiveActivity")
                let state = MMTWidgetExtensionAttributes.ContentState(value: 1)
            
                do {
                    
                    let activity = try Activity<MMTWidgetExtensionAttributes>.request(attributes: attr, content: ActivityContent(state: state, staleDate: nil))
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    @IBAction func updateActivity(_ sender: Any) {
        if #available(iOS 16.2, *) {
            Task {
                let state = MMTWidgetExtensionAttributes.ContentState(value: 1)
                for activity in Activity<MMTWidgetExtensionAttributes>.activities {
                    await activity.update(using: state)
                }
            }
        }
        
        
    }
    
    @IBAction func removeActivity(_ sender: Any) {
        
        if #available(iOS 16.2, *) {
            Task {
                for activity in Activity<MMTWidgetExtensionAttributes>.activities {
                    await activity.end(nil, dismissalPolicy: .immediate)
                }
            }
        }
    }
}


