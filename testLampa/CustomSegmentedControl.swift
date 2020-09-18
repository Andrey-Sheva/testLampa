//
//  CustomSegmentedControl.swift
//  testLampa
//
//  Created by Андрей Шевчук on 16.09.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UIView {
    
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var textColor: UIColor = .lightText
    var selectorColor: UIColor = .white
    
    convenience init(frame: CGRect, buttonTitles: [String]) {
           self.init(frame: frame)
           self.buttonTitles = buttonTitles
       }
    
    private func configStackView(){
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        for button in buttons{
            stackView.addArrangedSubview(button)
        }
    }
    
    
    private func configSelectView(){
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0,
                                            y: self.frame.height,
                                            width: selectorWidth,
                                            height: 2))
        selectorView.backgroundColor = selectorColor
        addSubview(selectorView)
    }
    
    private func createButtons(){
        buttons = [UIButton]()
            for buttonTitle in buttonTitles{
                let button = UIButton(type: .system)
                button.setTitle(buttonTitle, for: .normal)
                button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
                button.setTitleColor(selectorColor, for: .normal)
                buttons.append(button)
            }
        buttons[0].setTitleColor(selectorColor, for: .normal)
    }
    
    @objc func buttonAction(sender: UIButton){
        for(buttonIndex, button) in buttons.enumerated(){
            button.setTitleColor(textColor, for: .normal)
            if button == sender{
                let selectorPosition = frame.width / CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                button.setTitleColor(selectorColor, for: .normal)
            }
        }
    }
    private func updateView(){
        createButtons()
        configSelectView()
        configStackView()
    }
   
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
}
