//
//  DataRow.swift
//  AccordionSwiftUI
//
//  Created by Anoop M on 2019-06-16.
//  Copyright © 2019 Anoop M. All rights reserved.
//

import SwiftUI

struct DataRow: View {
    @ObservedObject var myData: AMPGenericObject

    var body: some View {
        return HStack {
            Text(myData.name ?? "Anonymous")
            Spacer()
            // PresentationButton(Text("Show Detail View"), destination: ProductDetail(product: myData))
            if myData.isExpanded {
                Image(systemName: "chevron.down")
            } else if myData.canBeExpanded {
                Image(systemName: "chevron.right")
            }
        }
        .frame(height: 44)
        .padding(.leading, CGFloat(CGFloat((myData.level ?? 1) * 15)))
        .background(Color(UIColor.systemBackground))
    }
}

#if DEBUG
struct DataRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DataRow(myData: DataStore.shared().dataRows[0])
            DataRow(myData: DataStore.shared().dataRows[1])
        }
    }
}
#endif
