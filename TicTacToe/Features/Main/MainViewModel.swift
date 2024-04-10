//
//  MainViewModel.swift
//  TicTacToe
//
//  Created by Вадим on 08.04.2024.
//

import Foundation

final class MainViewModel: MainViewModelProtocol {
    @Published
    var ticTacToeDict: [String : String] = [:]
    
    @Published
    var showingWinner = false
    
    @Published
    var sign = ""
    
    @Published
    var isTimeStop = false
    
    @Published
    private(set) var personScore = 0
    
    @Published
    private(set) var computerScore = 0
    
    func nextStep() {
        isTimeStop = true
        DispatchQueue.global().async {
            let ticTacToePositionArray = self.ticTacToeDict.keys
            
            if self.checkForVictory("multiply") && ticTacToePositionArray.count > 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    self.showingWinner = true
                    self.isTimeStop = false
                    self.sign = "Победили крестики!!!"
                    self.personScore += 1
                }
            } else {
                
                var allPositionArray = ["00", "01", "02", "10", "11", "12", "20", "21", "22"]
                
                for element in ticTacToePositionArray {
                    if allPositionArray.contains(element) {
                        allPositionArray.removeAll { $0 == element }
                    }
                }
                if let randomElement = self.getRandomElement(from: allPositionArray) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        self.ticTacToeDict[randomElement] = "circle"
                        AudioService.shared.playCircleActionSound()
                        self.isTimeStop = false
                        if self.checkForVictory("circle") && ticTacToePositionArray.count > 4 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                self.showingWinner = true
                                self.isTimeStop = false
                                self.sign = "Победили нолики!!!"
                                self.computerScore += 1
                            }
                        }
                    }
                }
                
                if allPositionArray.isEmpty && ticTacToePositionArray.count > 4 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        self.showingWinner = true
                        self.isTimeStop = false
                        self.sign = "Ничья"
                    }
                }
            }
        }
    }
    
    func isButtonActive(_ row: Int, _ column: Int) -> Bool {
        guard let cellValue = ticTacToeDict["\(row)\(column)"] else {
            return true
        }
        return cellValue != "multiply" && cellValue != "circle"
    }
    
    private func getRandomElement(from array: [String]) -> String? {
        return array.randomElement()
    }
    
    private func checkForVictory(_ value: String) -> Bool {
        let ticTacToePositionArray = ticTacToeDict.filter { $0.value == value }.map { $0.key }
        let winPositions = [["00", "01", "02"], ["10", "11", "12"], ["20", "21", "22"], ["00", "10", "20"], ["01", "11", "21"], ["02", "12", "22"], ["00", "11", "22"], ["02", "11", "20"]]
            
        for position in winPositions {
            if Set(position).isSubset(of: ticTacToePositionArray) {
                return true
            }
        }
        
        return false
    }
}

