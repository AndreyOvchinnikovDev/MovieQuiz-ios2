import UIKit

final class MovieQuizViewController: UIViewController {
    private let image: UIImageView = {
       let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.backgroundColor = A.Colors.ypWhite.color
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = A.Images.killBill.image
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let questionLabel: UILabel = {
       let label = UILabel()
        label.font = FontFamily.YSDisplay.medium.font(size: 20)
        label.textColor = A.Colors.ypWhite.color
        label.text = "Вопрос:"
        return label
    }()
    
    private let containerForRatingLabel: UIView = {
       let view = UIView()
        return view
    }()
    
    private let ratingLabel: UILabel = {
       let label = UILabel()
        label.font = FontFamily.YSDisplay.bold.font(size: 23)
        label.textColor = A.Colors.ypWhite.color
        label.text = "Рейтинг Этого фильма меньше 5?"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countQuestionLabel: UILabel = {
       let label = UILabel()
        label.font = FontFamily.YSDisplay.medium.font(size: 20)
        label.textColor = A.Colors.ypWhite.color
        label.textAlignment = .right
        label.text = "1/10"
        return label
    }()
    
    private let stackLabels: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mainStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackButtons: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
   lazy private var yesButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = A.Colors.ypWhite.color
        button.layer.cornerRadius = 15
        button.setTitle("Да", for: .normal)
        button.setTitleColor(A.Colors.ypBlack.color,
                             for: .normal)
        button.titleLabel?.font = FontFamily.YSDisplay.medium.font(size: 20)
        button.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        return button
    }()
    
   lazy private var noButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = A.Colors.ypWhite.color
        button.layer.cornerRadius = 15
        button.setTitle("Нет", for: .normal)
        button.setTitleColor(A.Colors.ypBlack.color,
                             for: .normal)
        button.titleLabel?.font = FontFamily.YSDisplay.medium.font(size: 20)
        button.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let questions: [QuizQuestion] = [
            QuizQuestion(
                image: A.Images.theGodfather.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: A.Images.theDarkKnight.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: A.Images.killBill.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: A.Images.theAvengers.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: A.Images.deadpool.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: A.Images.theGreenKnight.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: true),
            QuizQuestion(
                image: A.Images.old.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: A.Images.theIceAgeAdventuresOfBuckWild.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: A.Images.tesla.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false),
            QuizQuestion(
                image: A.Images.vivarium.image,
                text: "Рейтинг этого фильма больше чем 6?",
                correctAnswer: false)
        ]
    
    private var currentQuestionNumber = 0
    private var correctAnswer = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()   
        view.backgroundColor = A.Colors.ypBlack.color
        addViews()
        setupConstraints()
        show(quiz: convert(model: questions[currentQuestionNumber]))
        
    }
    
    private func addViews() {
        view.addSubview(mainStack)
        containerForRatingLabel.addSubview(ratingLabel)
        stackButtons.addArrangedSubview(noButton)
        stackButtons.addArrangedSubview(yesButton)
        stackLabels.addArrangedSubview(questionLabel)
        stackLabels.addArrangedSubview(countQuestionLabel)
        mainStack.addArrangedSubview(stackLabels)
        mainStack.addArrangedSubview(image)
        mainStack.addArrangedSubview(containerForRatingLabel)
        mainStack.addArrangedSubview(stackButtons)
        
        }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: containerForRatingLabel.leadingAnchor, constant: 42),
            ratingLabel.trailingAnchor.constraint(equalTo: containerForRatingLabel.trailingAnchor, constant: -42),
            ratingLabel.topAnchor.constraint(equalTo: containerForRatingLabel.topAnchor, constant: 10),
            ratingLabel.bottomAnchor.constraint(equalTo: containerForRatingLabel.bottomAnchor, constant: -10),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 3/2),
            stackButtons.heightAnchor.constraint(equalToConstant: 60),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func show(quiz step: QuizStepViewModel) {
        currentQuestionNumber += 1
        ratingLabel.text = step.question
        image.image = step.image
        countQuestionLabel.text = step.questionNumber
    }

    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(title: result.title,
                                      message: result.text,
                                      preferredStyle: .alert)
        let button = UIAlertAction(title: result.buttonText, style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            self.currentQuestionNumber = 0
            self.correctAnswer = 0
            self.show(quiz: convert(model: questions[currentQuestionNumber]))
        }
        
        alert.addAction(button)
        self.present(alert, animated: true)
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        buttonsIsEnabled(false)
        if questions.count < currentQuestionNumber { return }
        let question = questions[currentQuestionNumber - 1]
        if question.correctAnswer == isCorrect {
            correctAnswer += 1
        }
        setupBorderColor(isCorrect: question.correctAnswer == isCorrect)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.buttonsIsEnabled(true)
            self.showNextQuestionOrResults()
            self.removeBorderColor()
        }
    }
    
    private func showNextQuestionOrResults() {
            if currentQuestionNumber < questions.count {
                show(quiz: convert(model: questions[currentQuestionNumber]))
            } else {
                show(quiz: QuizResultsViewModel(title: "Раунд окончен!",
                                                text: "Ваш результат \(correctAnswer)/10",
                                                buttonText: "Сыграть еще раз"))
        }
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(image: model.image, question: model.text, questionNumber: String(currentQuestionNumber + 1) + "/" + String(questions.count))
    }
    
    private func setupBorderColor(isCorrect: Bool) {
        let color = isCorrect ? A.Colors.ypGreen.color.cgColor :
        A.Colors.ypRed.color.cgColor
        image.layer.borderWidth = 8
        image.layer.borderColor = color
    }
    
    private func removeBorderColor() {
        image.layer.borderWidth = 0
    }
    
    private func buttonsIsEnabled(_ bool: Bool) {
        yesButton.isEnabled = bool
        noButton.isEnabled = bool
    }
    
    @objc private func yesButtonTapped() {
        showAnswerResult(isCorrect: true)
    }
    
    @objc private func noButtonTapped() {
        showAnswerResult(isCorrect: false)
    }
}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
