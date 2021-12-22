struct GameState: Hashable {
    let player1Position, player2Position: Int
    let player1Score, player2Score: Int
}


var gameStates = [GameState(player1Position: 2, player2Position: 3, player1Score: 0, player2Score: 0): 1]

var player1sTurn = true
while gameStates.contains(where: { $0.key.player1Score < 21 && $0.key.player2Score < 21 }) {
    var newGameStates = [GameState: Int]()
    
    for (state, universeCount) in gameStates {
        if state.player1Score < 21 && state.player2Score < 21 {
            for roll1 in 1...3 {
                for roll2 in 1...3 {
                    for roll3 in 1...3 {
                            let newPlayer1Position, newPlayer2Position, newPlayer1Score, newPlayer2Score: Int
                            if player1sTurn {
                                newPlayer1Position = (state.player1Position + roll1 + roll2 + roll3) % 10
                                newPlayer1Score = state.player1Score + newPlayer1Position + 1
                                newPlayer2Position = state.player2Position
                                newPlayer2Score = state.player2Score
                            } else {
                                newPlayer1Position = state.player1Position
                                newPlayer1Score = state.player1Score
                                newPlayer2Position = (state.player2Position + roll1 + roll2 + roll3) % 10
                                newPlayer2Score = state.player2Score + newPlayer2Position + 1
                            }
                            
                            let newState = GameState(player1Position: newPlayer1Position, player2Position: newPlayer2Position, player1Score: newPlayer1Score, player2Score: newPlayer2Score)
                            
                            newGameStates[newState] = newGameStates[newState, default: 0] + universeCount
                    }
                }
            }
        } else {
            newGameStates[state] = newGameStates[state, default: 0] + universeCount
        }
    }
    
    gameStates = newGameStates
    
    player1sTurn.toggle()
}


let (player1Wins, player2Wins) = gameStates.reduce(into: (0, 0), { if $1.key.player1Score >= 21 { $0.0 += $1.value } else { $0.1 += $1.value } })

print(max(player1Wins, player2Wins))
