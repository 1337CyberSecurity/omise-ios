//
//  NewAtomeFormViewModel.swift
//  OmiseSDK
//
//  Created by Andrei Solovev on 31/5/23.
//  Copyright © 2023 Omise. All rights reserved.
//

import Foundation

class NewAtomeFormViewModel: NewAtomeFormViewModelProtocol {
    var fields: [Field] = [
        .name,
        .email,
        .phoneNumber,
        .street1,
        .street2,
        .city,
        .state,
        .country,
        .postalCode
    ]

    var fieldForShippingAddressHeader: Field? { .street1 }
    var submitButtonTitle = "Atome.submitButton.title".localized()
    var headerText = "Atome.header.text".localized()
    var logoName = "Atome_Big"

    init(flowSession: PaymentCreatorFlowSession?) {
    }

    func title(for field: Field) -> String? {
        var title: String
        switch field {
        case .phoneNumber:
            title = field.title.localized() + " " + "Atome.field.phoneNumber.hint".localized()
        default:
            title = field.title.localized()
        }
        if field.isOptional {
            title += " " + "Atome.field.optional".localized()
        }

        return title
    }

    func error(for field: Field, validate text: String?) -> String? {
        if field.isOptional, text?.isEmpty ?? true { return nil }

        if let validatorRegex = field.validatorRegex,
            let regex = try? NSRegularExpression(pattern: validatorRegex, options: []) {
            do {
                try regex.validate(text ?? "")
                return nil
            } catch {
                return field.error ?? error.localizedDescription
            }
        } else {
            if let text = text, text.isEmpty {
                return field.error
            }
        }

        return nil
    }

    func onSubmitButtonPressed(_ viewContext: ViewContext, onComplete: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            onComplete()
        }
    }
}
