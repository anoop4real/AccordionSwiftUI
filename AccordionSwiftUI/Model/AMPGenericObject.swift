//
//  AMPGenericObject.swift
//  AccordionSwiftUI
//
//  Created by Anoop M on 2019-06-16.
//  Copyright © 2019 Anoop M. All rights reserved.
//

import Foundation
import SwiftUI

class AMPGenericObject: Identifiable {
    var id: String = ""
    var name:String?
    var parentName:String?
    var canBeExpanded = false // Bool to determine whether the cell can be expanded
    var isExpanded = false    // Bool to determine whether the cell is expanded
    var level:Int?            // Indendation level of tabelview
    var type:Int?
    var children:[AMPGenericObject] = []
    
    enum ObjectType:Int{
        case object_TYPE_CATEGORY = 0
        case object_TYPE_PRODUCT
        case object_TYPE_SUBPRODUCT
    }
}
