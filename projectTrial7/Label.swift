//
//  Label.swift
//  projectTrial7
//
//  Created by Tatyana on 2/3/22.
//

import Foundation
import UIKit

protocol LabelDelegate: AnyObject {
    
    func gameOver()
}

class Label: UILabel {
    
    var count = 0
    var circle: UIView!
    weak var myDelegate: LabelDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if circle != nil {
            if circle.backgroundColor == self.backgroundColor {
                self.count = count + 1
                self.text = String(count)
            } else {
                self.myDelegate.gameOver()
            }
            
        }
    }
    
    func animateDissapearing() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
    }
}
