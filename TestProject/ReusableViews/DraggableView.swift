//
//  DraggableView.swift
//  TestProject
//
//  Created by Ritik Sharma on 01/02/23.
//

import UIKit

class DraggableView: UIView {

    
    // tagForCrossButton  = 1
    @IBOutlet var crossButton: UIButton!
    // tagForImageView = 2
    @IBOutlet var imageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    private func commonInit(){

    }
    override func layoutSubviews() {
        self.crossButton.tag = 1
        self.imageView.tag = 2
    }
    @IBAction func crossTapped(_ sender: Any) {
        
    }

}
