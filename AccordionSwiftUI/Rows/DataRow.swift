//
//  DataRow.swift
//  AccordionSwiftUI
//
//  Created by Anoop M on 2019-06-16.
//  Copyright © 2019 Anoop M. All rights reserved.
//

import SwiftUI

struct DataRow : View {
    var myData: AMPGenericObject
    
    var body: some View {
        
        HStack {
            Text(myData.name ?? "Anonymous")
            Spacer()
            if myData.isExpanded{
                Image(systemName: "chevron.down")
            }else if myData.canBeExpanded{
                Image(systemName: "chevron.right")
            }
        }
        .padding(.leading, CGFloat(CGFloat((myData.level ?? 1) * 15)))
    }
}

#if DEBUG
struct DataRow_Previews : PreviewProvider {
    static var previews: some View {
        Group{
            DataRow(myData: DataStore.shared().dataRows[0])
            DataRow(myData: DataStore.shared().dataRows[1])
        }
    }
}
#endif
