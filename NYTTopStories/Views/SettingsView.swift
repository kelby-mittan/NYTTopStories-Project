//
//  SettingsView.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/10/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    public lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        
        return pv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupPickerViewConstraints()
    }
    
    private func setupPickerViewConstraints() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
