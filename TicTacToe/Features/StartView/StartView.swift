//
//  StartView.swift
//  TicTacToe
//
//  Created by Вадим on 09.04.2024.
//

import SwiftUI

struct StartView: View {
    
    @State private var isShowedView = false
    
    var body: some View {
        contentView
            .onAppear {
                AudioService.shared.playBackgroundMusic()
            }
            .fullScreenCover(isPresented: $isShowedView) {
                MainView()
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        ZStack {
            backgroundImage
            startGameButton
        }
    }
    
    @ViewBuilder
    private var backgroundImage: some View {
        Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    private var startGameButton: some View {
        VStack {
            Spacer()
            Button(action: {
                isShowedView = true
            }) {
                Text(Constants.buttonName)
                    .padding(Constants.buttonPadding)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .cornerRadius(Constants.buttonRadius)
            }
        }
    }
}

private enum Constants {
    static let buttonName = "Начать игру"
    static let buttonRadius: CGFloat = 10
    static let buttonPadding: CGFloat = 15
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
