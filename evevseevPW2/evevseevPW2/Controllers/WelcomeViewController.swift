//
//  WelcomeViewController.swift
//  evevseevPW2
//
//  Created by Евгений Евсеев on 30.09.2022.
//

import UIKit


final class WelcomeViewController: UIViewController {
    
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let incrementButton = UIButton()
    private let commentView = UIView()
    
    
    private var value: Int = 0;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateUI()
    }
    
    private func updateUI(animate: Bool = false) {
        if (animate) {
            UIView.transition(
                with: commentView,
                duration: 0.25,
                options: .transitionCrossDissolve,
                animations: {self.updateCommentLabel(value: self.value)},
                completion: nil
            )
        } else {
            updateCommentLabel(value: self.value)
        }
        valueLabel.text = "\(self.value)"
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Prese Me", for: .normal)
        incrementButton.setTitleColor(.secondaryLabel, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        incrementButton.backgroundColor = UIColor(named: "LabelBackground")
        incrementButton.layer.applyShadow()
        
        self.view.addSubview(incrementButton)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.setHeight(48)
        
        incrementButton.addTarget(
            self,
            action: #selector(incrementButtonPressed),
            for: .touchDown)
        incrementButton.addTarget(self, action: #selector(incrementButtonReleased), for: .touchUpInside)
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .label
        valueLabel.text = "\(value)"
        
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.safeAreaLayoutGuide.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }
    
    private func setupCommentView() {
        commentView.backgroundColor = UIColor(named: "LabelBackground")
        commentView.layer.cornerRadius = 12
        
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor, 10)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        
        commentLabel.font = .systemFont(ofSize: 14.0,weight: .regular)
        commentLabel.textColor = .secondaryLabel
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView,
            [.top: 16, .left: 16, .bottom: 16, .right: 16]
        )
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = UIColor(named: "LabelBackground")
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")
        
        let buttonsSV = UIStackView(
            arrangedSubviews: [colorsButton, notesButton, newsButton]
        )
        
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "Background")
        commentView.isHidden = true
        
    
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 2...3:
            commentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        case 0...40:
            commentLabel.text = "\(value / 10 + 1)"
        case 40...50:
            commentLabel.text = "!1!1!1!1!"
        case 50...60:
            commentLabel.text = "big dude"
        case 60...70:
            commentLabel.text = "yyyuuuuuhaaaaa"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
        case 80...90:
            commentLabel.text = "80+"
        case 90...100:
            commentLabel.text = "1.0.0"
        default:
            break
        }
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        updateUI(animate: true)
    }
    
    @objc
    private func incrementButtonReleased() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
