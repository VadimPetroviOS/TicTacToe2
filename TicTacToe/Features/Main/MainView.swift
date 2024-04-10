//
//  MainView.swift
//  TicTacToe
//
//  Created by Вадим on 06.04.2024.
//

import SwiftUI

struct MainView<ViewModel: MainViewModelProtocol>: View {
    @StateObject
    private var viewModel: ViewModel
    
    @State private var showStartView = false
    
    // MARK: - Initializing View

    init() where ViewModel == MainViewModel {
        _viewModel = StateObject(
            wrappedValue: MainViewModel()
        )
    }
    
    var body: some View {
        contentView
            .fullScreenCover(isPresented: $showStartView) {
                StartView()
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        ZStack {
            backgroundImage
            VStack {
                Spacer()
                playField
                Spacer()
                scoreView
            }
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
    private var playField: some View {
        VStack(spacing: 20) {
            ForEach(0 ..< 3, id:\.self) { row in
                HStack(spacing: 20) {
                    ForEach(0 ..< 3, id:\.self) { column in
                        Button(action: {
                            viewModel.ticTacToeDict["\(row)\(column)"] = "multiply"
                            AudioService.shared.playCrossActionSound()
                            viewModel.nextStep()
                        }) {
                            Image(systemName: viewModel.ticTacToeDict["\(row)\(column)"] ?? "")
                                .imageScale(.large)
                                .foregroundColor(.black)
                                .frame(width: Constants.cellWidth, height: Constants.cellHeight)
                                .background(Color.yellow)
                        }
                        .disabled(viewModel.isTimeStop)
                        .alert(isPresented: $viewModel.showingWinner) {
                            Alert(
                                title: Text(viewModel.sign),
                                message: Text(Constants.playAgain),
                                primaryButton: .default(Text(Constants.primaryButtonText)) {
                                    viewModel.ticTacToeDict = [:]
                                },
                                secondaryButton: .default(Text(Constants.secondaryButtonText)) {
                                    showStartView = true
                                }
                            )
                        }
                        .allowsHitTesting(
                            viewModel.isButtonActive(row,column)
                        )
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var scoreView: some View {
        HStack {
            Spacer()
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: Constants.scoreImageWidth, height: Constants.scoreImageHeight)
                Text(": \(viewModel.personScore)")
                    .font(.system(size: Constants.textHeight))
            }
            Spacer()
            HStack {
                Image(systemName: "desktopcomputer")
                    .resizable()
                    .frame(width: Constants.scoreImageWidth, height: Constants.scoreImageHeight)
                Text(": \(viewModel.computerScore)")
                    .font(.system(size: Constants.textHeight))
            }
            Spacer()
        }
    }
}

private enum Constants {
    static let cellWidth: CGFloat = 50
    static let cellHeight: CGFloat = 50
    static let scoreImageWidth: CGFloat = 40
    static let scoreImageHeight: CGFloat = 40
    static let textHeight: CGFloat = 40
    static let playAgain = "Сыграем еще?"
    static let primaryButtonText = "ДА"
    static let secondaryButtonText = "НЕТ"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

