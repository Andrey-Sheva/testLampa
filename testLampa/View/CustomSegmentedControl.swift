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
    
    var view: UIView!
    
    var buttonTag = 0
    var textColor: UIColor = .lightText
    var selectorColor: UIColor = .white
    
    
    
    convenience init(frame: CGRect, buttonTitles: [String], view: UIView) {
            self.init(frame: frame)
            self.buttonTitles = buttonTitles
            self.view = view
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
            button.tag = buttonTag
            buttonTag += 1
        }
    }
    func configViewConstraints(view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            view.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func configSelectView(){
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0,
                                            y: self.frame.height,
                                            width: selectorWidth,
                                            height: 1))
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
                if button.tag >= 1{
                    superview?.addSubview(view)
                }else{
                    view.removeFromSuperview()
                }
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
