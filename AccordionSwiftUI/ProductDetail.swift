//
//  ProductDetail.swift
//  AccordionSwiftUI
//
//  Created by Anoop M on 2019-06-19.
//  Copyright © 2019 Anoop M. All rights reserved.
//

import SwiftUI

struct ProductDetail : View {
    var product:AMPGenericObject
    var body: some View {
        Text(product.name!)
    }
}

#if DEBUG
struct ProductDetail_Previews : PreviewProvider {
    static var previews: some View {
        ProductDetail(product: DataStore.shared().dataRows[0])
    }
}
#endif
