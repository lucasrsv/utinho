//
//  MiniGameView.swift
//  Uti
//
//  Created by lrsv on 02/09/23.
//

import SwiftUI
import SpriteKit
struct MiniGameView: View {
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                let screenSize = CGSize(width: geometry.size.width, height: geometry.size.height)
                SpriteView(scene: MiniGameScene(size: screenSize))
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .ignoresSafeArea(.all)
    }
}


struct MiniGameView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGameView()
    }
}
