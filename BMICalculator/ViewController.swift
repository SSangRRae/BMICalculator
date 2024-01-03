//
//  ViewController.swift
//  BMICalculator
//
//  Created by SangRae Kim on 1/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designTitleLabel()
        designSubTitileLabel()
        imageView.image = .image
        imageView.contentMode = .scaleAspectFill
        
        designQuestionLabels(heightLabel, text: "키가")
        designQuestionLabels(weightLabel, text: "몸무게는")
        
        designQuestionTextFields(heightTextField)
        designQuestionTextFields(weightTextField)
        
        designRandomButton()
        designResultButton()
    }

    func designTitleLabel() {
        titleLabel.text = "BMI Calculator"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    func designSubTitileLabel() {
        subTitleLabel.numberOfLines = 0
        subTitleLabel.text = "당신의 BMI 지수를\n알려드릴게요."
        subTitleLabel.textColor = .black
        subTitleLabel.font = .systemFont(ofSize: 15)
    }
    
    func designQuestionLabels(_ label: UILabel, text: String) {
        label.text = "\(text) 어떻게 되시나요?"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
    }
    
    func designQuestionTextFields(_ textField: UITextField) {
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.keyboardType = .numberPad
    }
    
    func designRandomButton() {
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.tintColor = .red
        randomButton.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
    }
    
    func designResultButton() {
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.backgroundColor = .purple
        resultButton.tintColor = .white
        resultButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        resultButton.layer.cornerRadius = 15
    }
}
