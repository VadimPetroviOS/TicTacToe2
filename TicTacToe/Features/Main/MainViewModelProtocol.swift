//
//  MainViewModelProtocol.swift
//  TicTacToe
//
//  Created by Вадим on 08.04.2024.
//

import Foundation

protocol MainViewModelProtocol: ObservableObject {
    var ticTacToeDict: [String: String] { get set }
    var showingWinner: Bool { get set }
    var sign: String { get set }
    var isTimeStop: Bool { get set }
    var personScore: Int { get }
    var computerScore: Int { get }
    func nextStep()
    func isButtonActive(_ row: Int, _ column: Int) -> Bool
}

