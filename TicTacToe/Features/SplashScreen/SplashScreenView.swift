//
//  SplashScreenView.swift
//  TicTacToe
//
//  Created by Вадим on 06.04.2024.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = Constants.initialSize
    @State private var opacity = Constants.initialOpacity
    
    var body: some View {
        if isActive {
            StartView()
        } else {
            logoView
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Constants.waitingTime) {
                        self.isActive = true
                    }
                }
        }
    }
    
    @ViewBuilder
    private var logoView: some View {
        Image("TicTacToeLogo")
            .resizable()
            .frame(width: Constants.imageWidth, height: Constants.imageHeight)
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: Constants.animationTime)) {
                    self.size = Constants.finalSize
                    self.opacity = Constants.finalOpacity
                }
            }
    }
}

private enum Constants {
    static let initialSize = 0.8
    static let initialOpacity = 0.5
    static let finalSize = 0.9
    static let finalOpacity = 1.0
    static let waitingTime = 2.0
    static let imageWidth: CGFloat = 200
    static let imageHeight: CGFloat = 200
    static let animationTime = 1.2
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

