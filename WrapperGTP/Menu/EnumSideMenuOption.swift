//
//  EnumSideMenuOption.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

enum SideMenuOption: Int, CaseIterable{
    case conversation1 = 0, conversation2, conversation3, conversation4, conversation5
    var title: String{
           switch self {
           case .conversation1:
               return "First"
           case .conversation2:
               return "Second"
           case .conversation3:
               return "Third"
           case .conversation4:
               return "Fourth"
           case .conversation5:
               return "Fifth"
           }
       }
    
}
