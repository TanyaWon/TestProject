//
//  LabelTimer.swift
//  projectTrial7
//
//  Created by Tatyana on 2/18/22.
//

import Foundation
import UIKit

protocol LabelTimerDelegate: AnyObject {
    
    func startGame()
}

class LabelTimer: UILabel {
    
    var count = 3
    weak var myDelegate: LabelTimerDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let fontSize = self.frame.height * 0.9
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.textAlignment = .center
        self.textColor = .black
        
        self.startOfCounting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startOfCounting() {
        if count > 0 {
            self.text = String(count)
            self.alpha = 1
            self.animateDesappearing()
        } else {
            self.removeFromSuperview()
        }
        
    }
    
    
    
    func animateDesappearing()  {
        UIView.animate(withDuration: 1) {
            self.alpha = 0
        } completion: { _ in
            if self.count == 3 {
                self.myDelegate.startGame()
            }
            self.count -= 1
            self.startOfCounting()
        }

    }
    
    deinit {
        print("labelTimer deinit")
    }
}
