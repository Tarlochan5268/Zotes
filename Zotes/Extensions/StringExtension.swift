//
//  StringExtension.swift
//  Zotes
//
//  Created by Kishore Narang on 2019-11-04.
//  Copyright © 2019 Zero. All rights reserved.
//

import Foundation

extension String
{
    func isEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    func convertToFirebaseCompatible() -> String
    {
        return self.replacingOccurrences(of: ".", with: "_");
    }
}
