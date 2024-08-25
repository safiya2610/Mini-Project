import Foundation

// To-Do List
struct Task {
    var title: String
    var isCompleted: Bool
}

class ToDoList {
    private var tasks: [Task] = []

    func addTask(title: String) {
        let newTask = Task(title: title, isCompleted: false)
        tasks.append(newTask)
        print("Task added: \(title)")
    }

    func viewTasks() {
        if tasks.isEmpty {
            print("Your To-Do list is empty.")
        } else {
            print("\nYour To-Do List:")
            for (index, task) in tasks.enumerated() {
                let status = task.isCompleted ? "[Completed]" : "[Pending]"
                print("\(index + 1). \(task.title) \(status)")
            }
        }
    }

    func markTaskAsCompleted(index: Int) {
        if index >= 0 && index < tasks.count {
            tasks[index].isCompleted = true
            print("Task marked as completed: \(tasks[index].title)")
        } else {
            print("Invalid task number.")
        }
    }

    func deleteTask(index: Int) {
        if index >= 0 && index < tasks.count {
            print("Task deleted: \(tasks[index].title)")
            tasks.remove(at: index)
        } else {
            print("Invalid task number.")
        }
    }
}

// Guessing Game
func playGuessingGame() {
    let targetNumber = Int.random(in: 1...100)
    var guess: Int? = nil

    print("Welcome to the Guessing Game!")
    print("I've selected a number between 1 and 100. Can you guess what it is?")

    while guess != targetNumber {
        print("Enter your guess: ", terminator: "")

        if let input = readLine(), let number = Int(input) {
            guess = number
            if guess! < targetNumber {
                print("Too low! Try again.")
            } else if guess! > targetNumber {
                print("Too high! Try again.")
            } else {
                print("Congratulations! You guessed the number!")
            }
        } else {
            print("Please enter a valid number.")
        }
    }
}

// Quiz Game
struct Question {
    let text: String
    let options: [String]
    let correctAnswerIndex: Int

    func isAnswerCorrect(index: Int) -> Bool {
        return index == correctAnswerIndex
    }
}

class QuizGame {
     var questions: [Question]
    private var score: Int
    private(set) var currentQuestionIndex: Int

    init(questions: [Question]) {
        self.questions = questions
        self.score = 0
        self.currentQuestionIndex = 0
    }

    func askQuestion() {
        guard currentQuestionIndex < questions.count else {
            print("No more questions!")
            return
        }

        let question = questions[currentQuestionIndex]
        print("\nQuestion \(currentQuestionIndex + 1): \(question.text)")
        for (index, option) in question.options.enumerated() {
            print("\(index + 1). \(option)")
        }
    }

    func answerQuestion(with index: Int) {
        guard currentQuestionIndex < questions.count else {
            print("No more questions!")
            return
        }

        let question = questions[currentQuestionIndex]
        if question.isAnswerCorrect(index: index - 1) {
            print("Correct!")
            score += 1
        } else {
            print("Incorrect. The correct answer was option \(question.correctAnswerIndex + 1).")
        }

        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            askQuestion()
        } else {
            print("\nQuiz Over! Your score is \(score) out of \(questions.count).")
        }
    }
}

func createQuestions() -> [Question] {
    return [
        Question(text: "What is the capital of Uttar Pradesh?", options: ["DELHI", "LUCKNOW", "SRI NAGAR", "VARANASI"], correctAnswerIndex: 1),
        Question(text: "Which planet is known as the GREEN Planet?", options: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswerIndex: 0),
        Question(text: "Which IIIT is best?", options: ["IIIT Una", "IIIT Delhi", "IIIT Lucknow", "IIITA"], correctAnswerIndex: 2)
    ]
}

// Tic-Tac-Toe Game
class TicTacToe {
    private var board: [[Character]]
    private var currentPlayer: Character

    init() {
        board = Array(repeating: Array(repeating: " ", count: 3), count: 3)
        currentPlayer = "X"
    }

    func drawBoard() {
        print("\n-------------")
        for row in board {
            print("|", terminator: "")
            for cell in row {
                print(" \(cell) |", terminator: "")
            }
            print("\n-------------")
        }
    }

    func playMove(row: Int, col: Int) -> Bool {
        if row >= 0 && row < 3 && col >= 0 && col < 3 && board[row][col] == " " {
            board[row][col] = currentPlayer
            return true
        } else {
            print("Invalid move. Try again.")
            return false
        }
    }

    func checkWin() -> Bool {
        for i in 0..<3 {
            if board[i][0] == currentPlayer && board[i][1] == currentPlayer && board[i][2] == currentPlayer {
                return true
            }
            if board[0][i] == currentPlayer && board[1][i] == currentPlayer && board[2][i] == currentPlayer {
                return true
            }
        }
        if board[0][0] == currentPlayer && board[1][1] == currentPlayer && board[2][2] == currentPlayer {
            return true
        }
        if board[0][2] == currentPlayer && board[1][1] == currentPlayer && board[2][0] == currentPlayer {
            return true
        }
        return false
    }

    func switchPlayer() {
        currentPlayer = (currentPlayer == "X") ? "O" : "X"
    }

    func isBoardFull() -> Bool {
        return !board.flatMap { $0 }.contains(" ")
    }

    func startGame() {
        var moveCount = 0
        while moveCount < 9 {
            drawBoard()
            print("Player \(currentPlayer), enter your move (row and column): ", terminator: "")
            if let input = readLine(), let row = Int(input.split(separator: " ")[0]), let col = Int(input.split(separator: " ")[1]) {
                if playMove(row: row, col: col) {
                    moveCount += 1
                    if checkWin() {
                        drawBoard()
                        print("Player \(currentPlayer) wins!")
                        return
                    }
                    switchPlayer()
                }
            } else {
                print("Invalid input. Please enter row and column numbers.")
            }
        }
        drawBoard()
        print("It's a draw!")
    }
}

// Main Menu Function
func showMenu() {
    print("""
    \nMenu:
    1. To-Do List
    2. Play Guessing Game
    3. Start Quiz
    4. Play Tic-Tac-Toe
    5. Exit
    """)
}

// Main Program Execution
let toDoList = ToDoList()
let questions = createQuestions()
let quizGame = QuizGame(questions: questions)
let ticTacToe = TicTacToe()
var shouldContinue = true

while shouldContinue {
    showMenu()
    if let choice = Int(readLine() ?? "") {
        switch choice {
        case 1:
            var toDoListActive = true
            while toDoListActive {
                print("""
                \nTo-Do List Menu:
                1. Add Task
                2. View Tasks
                3. Mark Task as Completed
                4. Delete Task
                5. Back to Main Menu
                """)
                if let toDoChoice = Int(readLine() ?? "") {
                    switch toDoChoice {
                    case 1:
                        print("Enter task title: ", terminator: "")
                        if let title = readLine(), !title.isEmpty {
                            toDoList.addTask(title: title)
                        } else {
                            print("Task title cannot be empty.")
                        }
                    case 2:
                        toDoList.viewTasks()
                    case 3:
                        toDoList.viewTasks()
                        print("Enter the number of the task to mark as completed: ", terminator: "")
                        if let taskNumber = Int(readLine() ?? ""), taskNumber > 0 {
                            toDoList.markTaskAsCompleted(index: taskNumber - 1)
                        } else {
                            print("Invalid task number.")
                        }
                    case 4:
                        toDoList.viewTasks()
                        print("Enter the number of the task to delete: ", terminator: "")
                        if let taskNumber = Int(readLine() ?? ""), taskNumber > 0 {
                            toDoList.deleteTask(index: taskNumber - 1)
                        } else {
                            print("Invalid task number.")
                        }
                    case 5:
                        toDoListActive = false
                    default:
                        print("Invalid choice.")
                    }
                }
            }

        case 2:
            playGuessingGame()

        case 3:
            quizGame.askQuestion()
            while quizGame.currentQuestionIndex < questions.count {
                print("Enter your answer (1-\(quizGame.questions[quizGame.currentQuestionIndex].options.count)): ", terminator: "")
                if let answer = Int(readLine() ?? ""), answer > 0 {
                    quizGame.answerQuestion(with: answer)
                } else {
                    print("Invalid answer. Please enter a number between 1 and \(quizGame.questions[quizGame.currentQuestionIndex].options.count).")
                }
            }

        case 4:
            ticTacToe.startGame()

        case 5:
            shouldContinue = false

        default:
            print("Invalid choice.")
        }
    }
}
print("Goodbye!")
