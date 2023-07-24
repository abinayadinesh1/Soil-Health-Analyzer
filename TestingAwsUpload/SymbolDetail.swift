//
//  SymbolDetail.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/26/23.
//

import Foundation
import SwiftUI

struct SymbolDetail: View {
    var symbol: CoverImage

    var body: some View {
        VStack {
            Text(symbol.name)
                .font(.system(.largeTitle, design: .rounded))

            symbol.cover
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(.accentColor)
        }
        .padding()
    }
}
