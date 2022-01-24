//
//  FilterTableViewCell.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-23.
//

import UIKit

protocol FilterTableViewCellDelegate: AnyObject {
    // Called when the user selected a make. Value is nil if "Any make" is selected
    func didSelectMake(value: String?)
    // Called when the user selected a model. Value is nil if "Any model" is selected
    func didSelectModel(value: String?)
}

class FilterTableViewCell: UITableViewCell {

    struct Item {
        let makes: [String]
        let models: [String]
    }
    
    @IBOutlet weak var filterBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    private let makePickerView = UIPickerView()
    private let modelPickerView = UIPickerView()
    private let pickerViewToolbar = UIToolbar()
    
    private weak var delegate: FilterTableViewCellDelegate?
    private var makes: [String]?
    private var models: [String]?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.filterBackgroundView.layer.cornerRadius = Constants.cornerRadius
        
        // Setup the textfields and their picker views
        self.makePickerView.dataSource = self
        self.modelPickerView.dataSource = self
        self.makePickerView.delegate = self
        self.modelPickerView.delegate = self
        self.makeTextField.inputView = self.makePickerView
        self.modelTextField.inputView = self.modelPickerView
        
        // Setup the toolbar to display the done button above the pickers
        self.pickerViewToolbar.sizeToFit()
        self.pickerViewToolbar.setItems([
            .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            .init(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
        ], animated: false)
        self.makeTextField.inputAccessoryView = self.pickerViewToolbar
        self.modelTextField.inputAccessoryView = self.pickerViewToolbar
        
        // Localize texts
        self.titleLabel.text = NSLocalizedString("CarList.Filter", comment: "")
        self.makeTextField.text = NSLocalizedString("CarList.Filter.Make", comment: "")
        self.modelTextField.text = NSLocalizedString("CarList.Filter.Model", comment: "")
    }
    
    func configure(item: Item, delegate: FilterTableViewCellDelegate) {
        self.delegate = delegate
        self.makes = item.makes
        self.models = item.models
    }
    
    @objc private func didTapDone() {
        self.makeTextField.resignFirstResponder()
        self.modelTextField.resignFirstResponder()
    }
}

extension FilterTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.makePickerView: return self.makes?.count ?? 0
        case self.modelPickerView: return self.models?.count ?? 0
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case self.makePickerView: return self.makes?[row] ?? ""
        case self.modelPickerView: return self.models?[row] ?? ""
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case self.makePickerView:
            self.makeTextField.text = self.makes?[row]
            self.delegate?.didSelectMake(value: row != 0 ? self.makes?[row] : nil)
        case self.modelPickerView:
            self.modelTextField.text = self.models?[row]
            self.delegate?.didSelectModel(value: row != 0 ? self.models?[row] : nil)
        default: break
        }
    }
}

extension FilterTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Disable editing of textfields in this view since they are implemented via pickers
        return false
    }
}
