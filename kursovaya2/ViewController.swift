//
//  ViewController.swift
//  kursovaya
//
//  Created by Матвей Матюшко on 25.12.2022.
//

import UIKit
import HealthKit
import SnapKit


class ViewController: UIViewController {
    
    let health = Health()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubview(healthText)
        stackView.addArrangedSubview(healthButton)
        
        return stackView
    }()
    
    private lazy var healthText: UILabel = {
        let text = UILabel(frame: CGRect(x: 220, y: 220, width: 100, height: 100))
        let profile = health.readProfile().age
        let newDate = DateFormatter()
        newDate.dateFormat = "dd-MM-yyyy"
        let stringDate = newDate.string(from: profile ?? Date.now)
        text.text = stringDate
        return text
    }()
    
//    private lazy var bloodTypeText: UILabel = {
//        let text = UILabel(frame: CGRect(x: 220, y: 220, width: 100, height: 100))
//        let profile = health.readProfile().bloodType
//        print(profile as? String)
//        text.text = profile as? String
//
//        return text
//    }()
    
    
    
    private lazy var healthButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("reload data", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        //button.backgroundColor = UIColor.init(hex: "E8E8EB")
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        
        let profile = health.readProfile().age
        let newDate = DateFormatter()
        newDate.dateFormat = "dd-MM-yyyy"
        let stringDate = newDate.string(from: profile ?? Date.now)
        healthText.text = stringDate
        
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        health.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                print("HealthKit authorization received.")
            }
            else
            {
                print("HealthKit authorization denied!")
                if error != nil {
                    print("\(String(describing: error))")
                }
            }
            
            
        }
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(verticalStackView)
        
    }
    
    func setupConstraints() {
        
        verticalStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        
        
    }
    
    
}

