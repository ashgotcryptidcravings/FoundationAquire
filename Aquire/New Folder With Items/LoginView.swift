import SwiftUI

struct LoginView: View {
    var onLogin: (String, String) -> Void

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.black, Color(red: 0.05, green: 0.01, blue: 0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                VStack(spacing: 8) {
                    Text("Aquire")
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundColor(.white)

                    Text("Foundation Device Access Portal")
                        .font(.system(size: 14))
                        .foregroundColor(Color.white.opacity(0.7))
                }

                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        #if os(iOS)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        #endif
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .foregroundColor(.white)
                        .cornerRadius(14)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 32)

                if showError {
                    Text("Enter a valid email and password to continue.")
                        .font(.caption)
                        .foregroundColor(Color.red.opacity(0.9))
                }

                Button(action: {
                    let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    if trimmedEmail.contains("@"), password.count >= 4 {
                        onLogin(trimmedEmail, password)
                    } else {
                        showError = true
                    }
                }) {
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Sign In")
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .padding(.horizontal, 50)
                    .padding(.vertical, 12)
                    .background(
                        Capsule().fill(
                            LinearGradient(
                                colors: [Color.purple, Color(red: 0.7, green: 0.3, blue: 1.0)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    )
                    .foregroundColor(.white)
                }
                .padding(.top, 8)

                Spacer()

                Text("Secure access · Foundation Network")
                    .font(.caption2)
                    .foregroundColor(Color.white.opacity(0.5))
                    .padding(.bottom, 24)
            }
        }
    }
}
