//
//  CheckField.swift
//  devMessage 2
//
//  Created by дэвид Кихтенко on 26.01.2023.
//

import UIKit

final class CheckField {

    static let shared = CheckField()

    private init() { }

    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private let passwordRegex = "(?=.*[A-Z0-9a-z]).{6,}"

    private func isValid(type: FieldType, data: String) -> Bool {
        let dataRegex: String

        switch type {
        case .email:
            dataRegex = emailRegex
        case .password:
            dataRegex = passwordRegex
        default:
            // Default case for other types
            dataRegex = ""
        }

        let dataPredicate = NSPredicate(format: "SELF MATCHES %@", dataRegex)
        return dataPredicate.evaluate(with: data)
    }

    @discardableResult
    func validField(_ field: UITextField, fieldType: FieldType) -> Bool {
        let fieldValue = field.text ?? ""

        switch fieldType {
        case .username, .generic:
            return validateGenericField(field, value: fieldValue, minLength: 3)

        case .login, .email:
            return validateSpecificField(field, value: fieldValue, type: .email)

        case .password, .confirmPassword:
            return validateSpecificField(field, value: fieldValue, type: .password)
        }
    }

    private func validateGenericField(_ field: UITextField, value: String, minLength: Int) -> Bool {
        let isValid = value.count >= minLength
        validView(field, isValid)
        return isValid
    }

    private func validateSpecificField(_ field: UITextField, value: String, type: FieldType) -> Bool {
        let isValid = isValid(type: type, data: value)
        validView(field, isValid)
        return isValid
    }

    private func validView(_ field: UITextField, _ valid: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0.2) {
            field.backgroundColor = valid ? .softGreen : .warmPink
        }
    }
}

enum FieldType {
    case username
    case login
    case email
    case password
    case confirmPassword
    case generic
}
