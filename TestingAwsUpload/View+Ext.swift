//
//  View+Ext.swift
//  TestingAwsUpload
//
//  Created by Justin Wong on 7/1/23.
//

import SwiftUI

struct CenterView: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

struct VerticalCenterView: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
    }
}

struct LeftAlignedView: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
        }
    }
}

struct RightAlignedView: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
        }
    }
}

struct EmptyTextView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(Color(uiColor: .lightGray))
    }
}

extension View {
    func centered() -> some View {
        modifier(CenterView())
    }
    
    func verticallyCentered() -> some View {
        modifier(VerticalCenterView())
    }
    
    func leftAligned() -> some View {
        modifier(LeftAlignedView())
    }
    
    func rightAligned() -> some View {
        modifier(RightAlignedView())
    }
    func emptyTextStyle() -> some View {
        modifier(EmptyTextView())
    }
}

