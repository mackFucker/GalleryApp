//
//  CheckField.swift
//  devMessage 2
//
//  Created by дэвид Кихтенко on 26.01.2023.
//

import UIKit

final class CheckField {
    
    static let shared = CheckField()
    init() { }
    
    private func isValid(_ type: String, _ data: String) -> Bool {
        var dataRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        if type != "email" {
            dataRegEx = "(?=.*[A-Z0-9a-z]).{6,}"
        }
        
        let dataPred = NSPredicate(format:"SELF MATCHES %@", dataRegEx)
        return dataPred.evaluate(with: data)
    }
    
    @discardableResult
    func validField(_ field: UITextField) -> Bool {
        let id = field.placeholder
        
        switch id {
        case "User name":
            if field.text?.count ?? 0 < 3 {
                validView(field, false)
                return false
            } else {
                validView(field, true)
                 return true
            }
        case "login", "email":
            if isValid("email", field.text!) {
               validView(field, true)
                return true
            } else {
                validView(field, false)
                return false
            }
        case "password" :
            if isValid("p", field.text!) {
                validView(field, true)
                return true
            } else {
                validView(field, false)
                return false
            }
        case "Confirm password":
            if isValid("p", field.text!) {
                validView(field, true)
                return true
            } else {
                validView(field, false)
                return false
            }
        default:
            if field.text?.count ?? 0 < 2 {
                validView(field, false)
                return false
            } else {
                validView(field, true)
                 return true
            }
        }
    }
    
    private func validView(_ field: UITextField, _ valid: Bool) {
        if valid {
            UIView.animate(withDuration: 0.2, delay: 0.2) {
                field.backgroundColor = .softGreen
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0.2) {
                if field.text!.count > 4 {
                    field.backgroundColor = .warmPink

                }
                else {
                    field.backgroundColor = .warmPink
                }
            }
        }
    }
}

