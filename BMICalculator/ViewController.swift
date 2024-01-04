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
    @IBOutlet var resetButton: UIButton!
    
    /*
    키: 110cm ~ 200cm
    몸무게: 40kg ~ 100kg
    */
    let minHeight = 110.0
    let maxHeight = 200.0
    let minWeight = 40.0
    let maxWeight = 100.0
    
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
        designResetButton()
        
        UserDefaults.standard.set("상래", forKey: "nickname")
    }
    
    // 키보드 내리기
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 랜덤 값 textField에 넣기
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        let height = String(format: "%.1f", randomDouble(what: "height"))
        let weight = String(format: "%.1f", randomDouble(what: "weight"))
        
        UserDefaults.standard.set(height, forKey: "height")
        UserDefaults.standard.set(weight, forKey: "weight")
        
        heightTextField.text = height
        weightTextField.text = weight
    }
    
    // 결과 확인!
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(heightTextField.text, forKey: "height")
        UserDefaults.standard.set(weightTextField.text, forKey: "weight")
        
        let height = textToDouble(heightTextField)
        let weight = textToDouble(weightTextField)
        
        // 키나 몸무게가 빈칸, 공백, 문자, 범위를 넘어서면 실패 alert
        if height == -1 || weight == -1 || !isRange(height: height, weight: weight) {
            showFailAlert()
        } else {
            let BMI = calculateBMI(height: height, weight: weight)
            let result = calculateResult(BMI)
            
            // 혹시 모르는 오류...
            if result == "오류" {
                showFailAlert()
            } else {
                showSuccesAlert(BMI: BMI, result: result)
            }
        }
    }
    
    // RESET 버튼 클릭 시
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "height")
        UserDefaults.standard.removeObject(forKey: "weight")
        
        subTitleLabel.text = "손님의 BMI 지수를\n알려드릴게요."
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    func calculateBMI(height: Double, weight: Double) -> Double {
        weight / ((height / 100) * (height / 100))
    }
    
    func calculateResult(_ BMI: Double) -> String {
        switch BMI {
            case 0 ..< 18.5: return "저체중"
            case 18.5 ..< 23: return "정상"
            case 23 ..< 25: return "과체중"
            case 25... : return "비만"
            default: return "오류"
        }
    }
    
    func isRange(height: Double, weight: Double) -> Bool {
        if minHeight <= height && height <= maxHeight && minWeight <= weight && weight <= maxWeight {
            return true
        }
        return false
    }
    
    func textToDouble(_ textField: UITextField) -> Double {
        guard let text = textField.text else {
            return -1
        }
        
        if let text = Double(text) {
            return text
        } else {
            return -1
        }
    }
    
    func showFailAlert() {
        let content = UIAlertController(title: "실패", message: "키 또는 몸무게의 값을 잘못 입력하셨습니다", preferredStyle: .alert)
        let button = UIAlertAction(title: "돌아가기", style: .default)
        
        content.addAction(button)
        
        present(content, animated: true)
    }
    
    func showSuccesAlert(BMI: Double, result: String) {
        let content = UIAlertController(title: "\(result)", message: "BMI 지수: \(String(format: "%.2f", BMI))", preferredStyle: .alert)
        let button = UIAlertAction(title: "돌아가기", style: .default)
        
        content.addAction(button)
        
        present(content, animated: true)
    }

    func randomDouble(what: String) -> Double {
        if what == "height" {
            return Double.random(in: minHeight...maxHeight)
        } else {
            return Double.random(in: minWeight...maxWeight)
        }
    }
    
    func designTitleLabel() {
        titleLabel.text = "BMI Calculator"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    func designSubTitileLabel() {
        subTitleLabel.numberOfLines = 0
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            subTitleLabel.text = "\(nickname)님의 BMI 지수를\n알려드릴게요."
        } else {
            subTitleLabel.text = "손님의 BMI 지수를\n알려드릴게요."
        }
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
        textField.keyboardType = .decimalPad
        if textField == heightTextField {
            setTextFieldsText(textField, value: "height")
        } else {
            setTextFieldsText(textField, value: "weight")
        }
    }
    
    func setTextFieldsText(_ textField: UITextField, value: String) {
        if let text = UserDefaults.standard.string(forKey: value) {
            textField.text = text
        } else {
            textField.text = ""
        }
    }
    
    func designRandomButton() {
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.tintColor = .blue
        randomButton.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
    }
    
    func designResultButton() {
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.backgroundColor = .purple
        resultButton.tintColor = .white
        resultButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        resultButton.layer.cornerRadius = 15
    }
    
    func designResetButton() {
        resetButton.setTitle("RESET", for: .normal)
        resetButton.tintColor = .red
        resetButton.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
    }
}
