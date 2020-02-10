//
//  SettingsViewController.swift
//  NYTTopStories
//
//  Created by Kelby Mittan on 2/6/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

struct RecentCategoryKey {
    static let category = "Category"
}

class SettingsViewController: UIViewController {

    private let settingsView = SettingsView()
    
    override func loadView() {
        view = settingsView
    }
    
    private let sections = ["Arts", "Automobiles", "Books", "Business", "Fashion", "Food", "Health", "Home", "Insider", "Magazine", "Movies", "NYRegion", "Obituaries", "Opinion", "Politics", "RealeEstate", "Science", "Sports", "SundayReview", "Technology", "Theater", "T-Magazine", "Travel", "Upshot", "US", "World"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        
        settingsView.pickerView.delegate = self
        settingsView.pickerView.dataSource = self
    }
    

}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
    

}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return sections[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let recentCategory = UserDefaults.standard.set(sections[row], forKey: RecentCategoryKey.category) as? String else { return }
       
    }
}
