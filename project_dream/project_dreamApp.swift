import SwiftUI
import CoreData

struct SleepTrackerView: View {
    @State private var isSleeping = false
    @State private var sleepStartTime: Date?
    @State private var sleepEndTime: Date?
    @State private var sleepDuration: TimeInterval = 0.0
    @State private var isLoginPresented = false
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var isSettingsViewPresented = false
    @State private var isAccountViewPresented = false
    @State private var startSleepCount = 0
    
    var body: some View {
        NavigationView {
            Group {
                if !isLoggedIn {
                    Button(action: {
                        isLoginPresented = true
                    }) {
                        Text("Zaloguj")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                    }
                    .sheet(isPresented: $isLoginPresented) {
                        LoginView(email: $email, password: $password, isLoggedIn: $isLoggedIn)
                            .onChange(of: isLoggedIn) { _ in
                                isLoginPresented = false
                            }
                    }
                }
            }
            .navigationBarTitle("Sleep Tracker", displayMode: .inline)
            .navigationBarItems(
                trailing: HStack {
                    if isLoggedIn {
                        Button(action: {
                            isAccountViewPresented = true
                        }) {
                            Text("Account")
                        }
                        .sheet(isPresented: $isAccountViewPresented) {
                            AccountView(startSleepCount: startSleepCount, sleepStartTime: sleepStartTime, sleepEndTime: sleepEndTime)
                        }
                    }
                    if isLoggedIn{
                        Button(action: {
                            isSettingsViewPresented = true
                        }) {
                            Image(systemName: "gearshape")
                                .font(.title)
                        }
                        .sheet(isPresented: $isSettingsViewPresented) {
                            SettingsView()
                        }
                    }
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

struct SleepView: View {
    @Binding var isSleeping: Bool
    @Binding var sleepStartTime: Date?
    @Binding var sleepEndTime: Date?
    @Binding var sleepDuration: TimeInterval
    @Binding var startSleepCount: Int // Liczba kliknięć na przycisk "Rozpocznij sen"

    var body: some View {
        VStack {
            Text(sleepStatusText)
                .font(.headline)

            Button(action: {
                toggleSleep()
                incrementStartSleepCount() // Zwiększ liczbę kliknięć na przycisk "Rozpocznij sen"
            }) {
                Text(isSleeping ? "Zakończ sen" : "Rozpocznij sen")
                    .font(.title)
                    .padding()
                    .background(isSleeping ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            if let startTime = sleepStartTime, let endTime = sleepEndTime {
                Text("Czas trwania: \(calculateDuration(startTime: startTime, endTime: endTime))")
                    .font(.headline)
                    .padding()
            }

        }
    }

    private var sleepStatusText: String {
        if isSleeping {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let sleepStartTimeString = formatter.string(from: sleepStartTime ?? Date())
            return "Śpię od \(sleepStartTimeString)"
        } else {
            return "Nie śpię"
        }
    }

    private func toggleSleep() {
        if isSleeping {
            // Zakończ sen
            isSleeping = false
            sleepEndTime = Date()
            if let startTime = sleepStartTime, let endTime = sleepEndTime {
                sleepDuration += endTime.timeIntervalSince(startTime)
            }
        } else {
            // Rozpocznij sen
            isSleeping = true
            sleepStartTime = Date()
            sleepEndTime = nil
        }
    }
    
    private func incrementStartSleepCount() {
        startSleepCount += 1
    }
    
    private func calculateDuration(startTime: Date, endTime: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let duration = endTime.timeIntervalSince(startTime)
        return formatter.string(from: duration) ?? ""
    }
}

struct LoginView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var isLoggedIn: Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("E-mail", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                .autocapitalization(.none)

            SecureField("Hasło", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: {
                if email == "admin" && password == "admin" {
                    isLoggedIn = true
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Zaloguj")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

struct AccountView: View {
    @State private var isShowingSettings = false
    var startSleepCount: Int // Liczba kliknięć na przycisk "Rozpocznij sen"
    var sleepStartTime: Date?
    var sleepEndTime: Date?
    
    var body: some View {
        VStack {
            if let startTime = sleepStartTime, let endTime = sleepEndTime {
                Text("Data rozpoczęcia snu: \(formattedDate(startTime))")
                    .font(.headline)
                    .padding()

                Text("Czas trwania snu: \(calculateDuration(startTime: startTime, endTime: endTime))")
                    .font(.headline)
                    .padding()
            } else {
                Text("Brak danych o śnie")
                    .font(.headline)
                    .padding()
            }
            
            // Данные пользователя
            Text("Imię: John Doe")
            Text("Wiek: 30")
            
            // Изображение из интернета
            URLImage(url: URL(string: "https://cdn.icon-icons.com/icons2/1154/PNG/512/1486564400-account_81513.png"))
                .frame(width: 100, height: 100)
                .cornerRadius(50)
        }
        .navigationBarItems(trailing:
            Button(action: {
                isShowingSettings = true
            }) {
                Image(systemName: "gear")
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView()
            }
        )
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func calculateDuration(startTime: Date, endTime: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let duration = endTime.timeIntervalSince(startTime)
        return formatter.string(from: duration) ?? ""
    }
}


// Пример реализации URLImage для загрузки изображения из интернета
struct URLImage: View {
    let url: URL?
    
    var body: some View {
        if let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    
    var body: some View {
        Form {
            Section(header: Text("Wygląd")) {
                Toggle(isOn: $isDarkModeEnabled) {
                    Text("Tryb nocny")
                }
            }
        }
        .onAppear {
            loadSettings()
        }
        .onChange(of: isDarkModeEnabled) { _ in
            saveSettings()
            applyAppearance()
        }
    }
    
    private func loadSettings() {
        if let isDarkModeEnabled = UserDefaults.standard.value(forKey: "isDarkModeEnabled") as? Bool {
            self.isDarkModeEnabled = isDarkModeEnabled
        }
    }
    
    private func saveSettings() {
        UserDefaults.standard.setValue(isDarkModeEnabled, forKey: "isDarkModeEnabled")
    }
    
    private func applyAppearance() {
        if #available(iOS 15.0, *) {
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .forEach { window in
                    if isDarkModeEnabled {
                        window.overrideUserInterfaceStyle = .dark
                    } else {
                        window.overrideUserInterfaceStyle = .light
                    }
                }
        } else {
            UIApplication.shared.windows.forEach { window in
                if isDarkModeEnabled {
                    window.overrideUserInterfaceStyle = .dark
                } else {
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
    }
}

@main
struct SleepTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SleepTrackerView()
            }
        }
    }
}
