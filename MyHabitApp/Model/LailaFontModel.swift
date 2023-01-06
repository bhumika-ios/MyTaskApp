//
//  LailaFontModel.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 06/01/23.
//

import Foundation
import SwiftUI

// MARK: Custom Font Extension

enum Laila{
    case light
    case bold
    case regular
    case medium
    case semibold


    var wight: Font.Weight{
        switch self{
        case .light:
            return .light
        case .bold:
            return .bold
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .semibold:
            return .semibold
        }
    }
}
