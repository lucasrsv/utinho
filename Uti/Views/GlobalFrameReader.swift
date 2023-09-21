//
//  GlobalFrameReader.swift
//  Uti
//
//  Created by lrsv on 20/09/23.
//

import Foundation
import SwiftUI

struct GlobalFrameReader<Content>: View where Content: View {
    let content: Content
    @Binding var globalFrame: CGRect

    init(content: Content, globalFrame: Binding<CGRect>) {
        self.content = content
        self._globalFrame = globalFrame
    }

    var body: some View {
        content.background(
            GeometryReader { geo in
                Color.clear.onAppear {
                    self.globalFrame = geo.frame(in: .global)
                }
            }
        )
    }
}
