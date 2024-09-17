//
//  StartMainView.swift
//  XO-game
//
//  Created by Nikkru on 30.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class StartMainView: UIView {
    
    var onAddComputerButtonAction: (() -> Void)?
    var onAddHumanButtonAction: (() -> Void)?
    
    //    MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
        addViewToSwitchStack()
        addAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var choiceComputerButton: UIButton = {
        let button = UIButton()
        button.setTitle("COMPUTER", for: .normal)
        button.setTitleColor((.darkGray), for: .normal)
        button.backgroundColor    = .white
        button.titleLabel?.font   = UIFont(name: "", size: 100)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var choiceHumanButton: UIButton = {
        let button = UIButton()
        button.setTitle("HUMAN", for: .normal)
        button.setTitleColor((.darkGray), for: .normal)
        button.backgroundColor    = .white
        button.titleLabel?.font   = UIFont(name: "", size: 100)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var humanSwitchLabel: UILabel = {
        let label = UILabel()
        label.text                      = "you would play vs"
        label.font                      = UIFont.systemFont(ofSize: 20)
        label.textAlignment             = .center
        label.numberOfLines             = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor                 = .white
        label.backgroundColor           = .darkGray
        label.layer.cornerRadius        = 8
        label.clipsToBounds             = true
        return label
    }()
    
    var computerSwitchLabel: UILabel = {
        let label = UILabel()
        label.text                      = "COMPUTER"
        label.font                      = UIFont.systemFont(ofSize: 20)
        label.textAlignment             = .center
        label.numberOfLines             = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor                 = .black
        if #available(iOS 13.0, *) {
            label.backgroundColor       = .systemBackground
        } else {
            label.backgroundColor       = .lightGray
        }
        label.layer.cornerRadius        = 8
        label.clipsToBounds             = true
        return label
    }()
    
    var stackSwitchView: UIStackView = {
        let stackView          = UIStackView()
        stackView.axis         = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private func setupViews() {
        addSubview(stackSwitchView)
    }
    
    private func addViewToSwitchStack() {
        stackSwitchView.addArrangedSubview(humanSwitchLabel)
        stackSwitchView.addArrangedSubview(choiceComputerButton)
        stackSwitchView.addArrangedSubview(choiceHumanButton)
//        stackSwitchView.addArrangedSubview(computerSwitchLabel)
    }
    
    //    MARK: - метод загрузки констрейнтов представлений
    private func setupConstraints() {
        setSwitchStackConstraints()
    }
    
    private func setSwitchStackConstraints() {
        stackSwitchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackSwitchView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40),
            stackSwitchView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func addAction() {
        choiceHumanButton.addTarget(self, action: #selector(addHumanButtonAction), for: .touchUpInside)
        choiceComputerButton.addTarget(self, action: #selector(addComputerButtonAction), for: .touchUpInside)
    }
    
    @objc func addComputerButtonAction() {
        onAddComputerButtonAction?()
    }
    
    @objc func addHumanButtonAction() {
        onAddHumanButtonAction?()
    }
}
