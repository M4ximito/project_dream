import UIKit

class SleepTrackerViewController: UIViewController {
    let sleepStatusLabel = UILabel()
    let sleepButton = UIButton()
    let setReminderButton = UIButton()
    
    var isSleeping = false
    var sleepStartTime: Date?
    var sleepDuration: TimeInterval = 0.0
    
    // Dodane elementy interfejsu użytkownika
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        sleepStatusLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
        sleepStatusLabel.textAlignment = .center
        sleepStatusLabel.font = UIFont.systemFont(ofSize: 24)
        updateSleepStatusLabel()
        view.addSubview(sleepStatusLabel)
        
        sleepButton.frame = CGRect(x: 50, y: 150, width: view.bounds.width - 100, height: 50)
        sleepButton.setTitle("Rozpocznij sen", for: .normal)
        sleepButton.addTarget(self, action: #selector(sleepButtonTapped), for: .touchUpInside)
        sleepButton.backgroundColor = UIColor.blue
        view.addSubview(sleepButton)
        
        
        // Konfiguracja elementów logowania
        usernameTextField.frame = CGRect(x: 50, y: 350, width: view.bounds.width - 100, height: 40)
        usernameTextField.placeholder = "Nazwa użytkownika"
        usernameTextField.borderStyle = .roundedRect
        view.addSubview(usernameTextField)
        
        passwordTextField.frame = CGRect(x: 50, y: 400, width: view.bounds.width - 100, height: 40)
        passwordTextField.placeholder = "Hasło"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
        
        loginButton.frame = CGRect(x: 50, y: 450, width: view.bounds.width - 100, height: 40)
        loginButton.setTitle("Zaloguj", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.backgroundColor = UIColor.green
        view.addSubview(loginButton)
    }
    
    @objc func sleepButtonTapped() {
        // ...
    }

    
    @objc func loginButtonTapped() {
        // Sprawdzanie poprawności danych logowania
        let validUsername = "user"
        let validPassword = "password"
        
        if usernameTextField.text == validUsername && passwordTextField.text == validPassword {
            // Logowanie udane
            // Możesz dodać logikę przejścia do innej części aplikacji po zalogowaniu
            print("Logowanie udane!")
        } else {
            // Logowanie nieudane
            print("Nieprawidłowa nazwa użytkownika lub hasło.")
        }
        
        // Wyczyść pola tekstowe po próbie logowania
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    func updateSleepStatusLabel() {
        // ...
    }
}
