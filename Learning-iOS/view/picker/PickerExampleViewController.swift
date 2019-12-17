//
//  PickerExampleViewController.swift
//  Learning-iOS
//
//  Created by 松本圭樹 on 2019/12/17.
//

import Foundation
import UIKit

class PickerExampleViewController: UIViewController {
    
    private let pickerView = UIPickerView()
    private let items = ["aaa", "bbb", "ccc", "ddd", "eee", "fff", "ggg"]
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: true)
    
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
    }
    @IBAction func didTapButton(_ sender: Any) {
    }
}

extension PickerExampleViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("select is \(row)")
    }
}

extension PickerExampleViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
}
