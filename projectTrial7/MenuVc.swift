//
//  ViewController.swift
//  projectTrial7
//
//  Created by Tatyana on 2/1/22.
//

import UIKit

class MenuVc: UIViewController {
    
    
    let labelForD = UILabel.init()
    var firstWordLabel = UILabel.init()
    var secondWordLabel = UILabel.init()
    var thirdWordLabel = UILabel.init()
    let button = UIButton.init()
    let labelRecord = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(red: 255 / 255, green: 246 / 255, blue: 136 / 255, alpha: 1)
        
        self.addLabelForD()
        self.addLines()
        self.createNameOfSecondLabel()
        self.createNameOfFirstLabel()
        self.createNameOfThirdLabel()
        self.createButton()
        self.createLabelRecord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setPoints()
    }
    
    
    func addLabelForD() {
        let offSet = UIScreen.main.bounds.width * 0.05
        labelForD.frame.size.width = UIScreen.main.bounds.width - offSet * 2
        labelForD.frame.size.height = labelForD.frame.size.width * 0.5
        labelForD.center.x = self.view.center.x
        labelForD.center.y = self.view.center.y
        let fontSize = UIScreen.main.bounds.width / 14.25
        labelForD.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        labelForD.text = "Click on the corresponding square's color of the circle, earn points and win!\nR u ready?\nWelcome to the game!"
        labelForD.numberOfLines = 0
        labelForD.textAlignment = .center
        labelForD.textColor = UIColor.init(red: 88 / 255, green: 119 / 255, blue: 204 / 255, alpha: 1)
        self.view.addSubview(labelForD)
    }
    
    
    func addLines() {
        let firstLine = self.createLine()
        firstLine.frame.origin.y = labelForD.frame.origin.y
        let secondLine = self.createLine()
        secondLine.frame.origin.y = labelForD.frame.origin.y + labelForD.frame.height
    }
    
    func createLine() -> UIView {
        let line = UIView.init()
        line.frame.size.width = UIScreen.main.bounds.width
        line.frame.size.height = line.frame.size.width * 0.01
        line.backgroundColor = labelForD.textColor
        self.view.addSubview(line)
        return line
    }
    
    func createNameOfSecondLabel() {
        secondWordLabel = createBasicLabel(text: "The")
        secondWordLabel.center.x = self.view.center.x
        secondWordLabel.center.y = labelForD.frame.origin.y / 2
    }
    
    func createNameOfFirstLabel() {
        firstWordLabel = createBasicLabel(text: "Catch")
        firstWordLabel.center.y = secondWordLabel.frame.origin.y - firstWordLabel.frame.size.height / 2
    }
    
    func createNameOfThirdLabel() {
        thirdWordLabel = createBasicLabel(text: "Color")
        thirdWordLabel.frame.origin.x = UIScreen.main.bounds.width - thirdWordLabel.frame.width
        thirdWordLabel.center.y = secondWordLabel.frame.origin.y + secondWordLabel.frame.size.height + thirdWordLabel.frame.size.height / 2
    }
    
    func createBasicLabel(text: String) -> UILabel {
        let label = UILabel.init()
        label.text = text.uppercased()
        label.textColor = UIColor.init(red: 100 / 200, green: 120 / 255, blue: 80 / 255, alpha: 1)
        let fontSize = UIScreen.main.bounds.width / 7.13
        label.font = UIFont.init(name: "GillSans-UltraBold", size: fontSize)
        label.textAlignment = .center
        label.frame.size.width = UIScreen.main.bounds.width * 0.6
        label.frame.size.height = 50
        self.view.addSubview(label)
        return label
    }
    
    func createButton() {
        button.frame.size.width = labelForD.frame.size.width * 0.7
        button.frame.size.height = button.frame.size.width * 0.4
        button.center.x = self.view.center.x
        button.center.y = UIScreen.main.bounds.height * 0.8
        button.setTitle("Start".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.init(red: 199 / 255, green: 199 / 255, blue: 255 / 255, alpha: 1)
        button.addTarget(self, action: #selector(transitionToGameVC), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func transitionToGameVC() {
        let gameVc = GameVC.init()
        self.navigationController?.pushViewController(gameVc, animated: true)
    }
    
   
    func createLabelRecord() {
//        labelRecord.text = "Your record is: "
        labelRecord.textColor = .black
        labelRecord.textAlignment = .center
        labelRecord.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        labelRecord.frame.size.width = UIScreen.main.bounds.width
        labelRecord.frame.size.height = labelRecord.frame.size.width * 0.2
        labelRecord.center.x = self.view.center.x
        labelRecord.center.y = (self.view.frame.height - (button.frame.height + button.frame.origin.y)) / 2 + (button.frame.height + button.frame.origin.y)
        self.view.addSubview(labelRecord)
    }
    
    func setPoints() {
        labelRecord.text = "Your record is: " + String(UserDefaults.standard.integer(forKey: "Record"))
    }
    
}
