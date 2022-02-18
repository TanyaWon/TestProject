//
//  GameVC.swift
//  projectTrial7
//
//  Created by Tatyana on 2/17/22.
//

import Foundation
import UIKit

class GameVC: UIViewController, LabelDelegate, LabelTimerDelegate {
    
    var mainTimer: Timer!
    let colors: [UIColor] = [.systemYellow, .systemOrange, .systemRed, .brown, .systemBrown]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.addLabels()
        self.createNumberTimer()
        
       
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainTimer.invalidate()
        mainTimer = nil
        if let circle = self.view.viewWithTag(10) {
            circle.removeFromSuperview()
        }
    }
    
    func addLabels() {
        guard let window = UIWindow.getWindow() else { return }
        let top = window.safeAreaInsets.top
        let gameHeight = UIScreen.main.bounds.height / 2 - top
        let cellHeight = gameHeight / CGFloat(colors.count)
        let cellWidth = UIScreen.main.bounds.width / CGFloat(colors.count)
        for i in 0 ..< colors.count {
            let label = createBasicLabel(width: cellWidth * 0.8)
            label.backgroundColor = colors[i]
            if i % 2 != 0 {
                label.center.x = UIScreen.main.bounds.width - cellWidth
            } else {
                label.center.x = cellWidth
            }
            label.frame.origin.y =  top + cellHeight / 2 + cellHeight * CGFloat(i)
        }
        
    }

    
    func createBasicLabel(width: CGFloat) -> Label {
        let label = Label.init()
        label.frame.size = CGSize.init(width: width, height: width)
        label.isUserInteractionEnabled = true
        self.view.addSubview(label)
        label.myDelegate = self
        
        return label
    }
    
    
    func createNumberTimer() {
        let width = UIScreen.main.bounds.width * 0.4
        let frame = CGRect.init(x: 0, y: 0, width: width, height: width)
        let label = LabelTimer.init(frame: frame)
        label.center.x = self.view.center.x
        label.center.y = UIScreen.main.bounds.height * 0.75
        self.view.addSubview(label)
        label.myDelegate = self
    }
    
    func startGame() {
        mainTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(removeCircle), userInfo: nil, repeats: true)
    }
    
    func createCircle() {
        let width = UIScreen.main.bounds.width * 0.4
        let cirle = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: width))
        cirle.layer.cornerRadius = cirle.frame.width / 2
        cirle.center.x = self.view.center.x
        cirle.center.y = UIScreen.main.bounds.height * 0.75
        cirle.backgroundColor = colors.randomElement()!
        cirle.tag = 10
        self.view.addSubview(cirle)
        
        for v in self.view.subviews {
            if v is Label {
                (v as! Label).circle = cirle
            }
        }
    }
    
  @objc func removeCircle() {
        if let circle = self.view.viewWithTag(10) {
            circle.removeFromSuperview()
            for v in self.view.subviews {
                if v is Label {
                    (v as! Label).circle = nil
                }
            }
        }
      Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.createCircle()
        }
    }
    
    func gameOver() {
        mainTimer.invalidate()
        if let circle = self.view.viewWithTag(10) {
            circle.removeFromSuperview()
        }
        var points = 0
        for v in self.view.subviews {
            if v is Label {
                points += (v as! Label).count
                (v as! Label).animateDissapearing()
            }
        }
        let userDefaults = UserDefaults.standard
        let record = userDefaults.integer(forKey: "Record")
        if points > record {
            userDefaults.set(points, forKey: "Record")
            userDefaults.synchronize()
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.createErrorLabel()
        }
    }
    
    func createErrorLabel() {
        let label = UILabel.init()
        label.frame.size.width = UIScreen.main.bounds.width
        label.frame.size.height = label.frame.size.width * 0.2
        label.center = self.view.center
        label.textAlignment = .center
        label.text = "Game over!"
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        self.view.addSubview(label)
    }
    
    deinit {
        print("Deinit gameVc")
    }
    
    
}


// MARK: - Get Window

extension UIWindow {
    
    class func getWindow() -> UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return window
    }
}
