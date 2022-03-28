//
//  GameMainView.swift
//  XO-game
//
//  Created by Nikkru on 23.03.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

final class GameMainView: UIView {
    
    //    Clogure для добавления target во viewController
    var onAddGameAction: (() -> Void)?

    
    //    MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
        addAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var restartButton: UIButton = {
        let button                = UIButton()
        button.setTitle("restart", for: .normal)
        button.setTitleColor((.white), for: .normal)
        button.backgroundColor    = .darkGray
        button.titleLabel?.font   = UIFont(name: "restart", size: 100)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var firstPlayerTurnLabel: UILabel = {
        let label = UILabel()
        label.text                      = "first player"
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
    
    var secondPlayerTurnLabel: UILabel = {
        let label = UILabel()
        label.text                      = "second player"
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
    
    var winnerLabel: UILabel = {
        let label = UILabel()
        label.text                      = "winner"
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
    
    var gameboardView: GameboardView = {
        let view = GameboardView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        return view
    }()
    
    func setupGameboardView() {
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.gameboardView.placeMarkView(XView(), at: position)
        }
    }
    
    private func setupViews() {
        addSubview(winnerLabel)
        addSubview(secondPlayerTurnLabel)
        addSubview(firstPlayerTurnLabel)
        addSubview(restartButton)
        addSubview(gameboardView)
    }
    
    private func setupConstraints() {
        setFirstPlayerTurnLabelConstraints()
        setSecondPlayerTurnLabelConstraints()
        setWinnerLabelConstraints()
        setGameboardViewConstraints()
        setRestartButtonConstraints()
    }
    
//    MARK: - Настраиваем констрейнты
    
    private func setFirstPlayerTurnLabelConstraints() {
        
        firstPlayerTurnLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstPlayerTurnLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40),
            firstPlayerTurnLabel.leftAnchor.constraint(lessThanOrEqualTo: self.leftAnchor, constant: 40),
            firstPlayerTurnLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -15),
        ])
    }
    
    private func setSecondPlayerTurnLabelConstraints() {
        
        secondPlayerTurnLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondPlayerTurnLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 40),
            secondPlayerTurnLabel.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -40),
            secondPlayerTurnLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 15),
        ])
    }
    
    private func setWinnerLabelConstraints() {
        
        winnerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            winnerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            winnerLabel.topAnchor.constraint(equalTo: firstPlayerTurnLabel.bottomAnchor, constant: 20),
        ])
    }
    
    private func setRestartButtonConstraints() {
        
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            restartButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            restartButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6),
            restartButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -40)
        ])
    }
    
    private func setGameboardViewConstraints() {
        
        gameboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            gameboardView.topAnchor.constraint(equalTo: winnerLabel.bottomAnchor, constant: 20),
            gameboardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            gameboardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            gameboardView.heightAnchor.constraint(equalTo: gameboardView.widthAnchor),
            gameboardView.bottomAnchor.constraint(lessThanOrEqualTo: restartButton.topAnchor, constant: -20)
        ])
    }
    
    func addAction() {
        restartButton.addTarget(self, action: #selector(self.addActionRestartButtonPressed), for: .touchUpInside)
    }
    
    @objc func addActionRestartButtonPressed() {
        onAddGameAction?()
    }
}
