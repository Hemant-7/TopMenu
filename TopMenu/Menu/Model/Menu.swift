//
//  Menu.swift
//  TopMenu
//
//  Created by Hemant kumar on 04/06/23.
//

import Foundation

enum Menu {
    case tabOne
    case tabTwo
    case tabThree
    
    var string: String {
        switch self {
        case .tabOne:
            return "Tab One"
        case .tabTwo:
            return "Tab Two"
        case .tabThree:
            return "Tab Three"
        }
    }
    
    static var menuListArray: [String] {
        return [tabOne.string, tabTwo.string, tabThree.string]
    }
    
    static func getType(from text: String) -> Menu? {
        switch text.lowercased() {
        case Menu.tabOne.string.lowercased():
            return .tabOne
        case Menu.tabTwo.string.lowercased():
            return .tabTwo
        case Menu.tabThree.string.lowercased():
            return .tabThree
        default:
            return nil
        }
    }
}
