import SwiftUI

struct LoginView: View {
    @State private var account: String = ""
    @State private var password: String = ""
    @State private var selectedCountry: String = "United Kingdom"
    @State private var showCountryPicker = false
    @State private var agreesToTerms: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                // Country Selector
                Button(action: {
                    showCountryPicker = true
                }) {
                    HStack {
                        Text(selectedCountry)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                .sheet(isPresented: $showCountryPicker) {
                    NavigationView {
                        CountryPickerView(selectedCountry: $selectedCountry)
                    }
                }
                
                // Account Field
                TextField("Please enter your account", text: $account)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                // Password Field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Terms Agreement
                HStack(alignment: .top) {
                    Toggle("", isOn: $agreesToTerms)
                        .labelsHidden()
                        .toggleStyle(CheckboxToggleStyle())
                    
                    Text(makeTermsText())
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }

                
                // Login Button
                Button(action: {
                    // Login action here
                }) {
                    Text("Log In")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(8)
                }
                
                // Forgot Password
                Button(action: {
                    // Forgot password action
                }) {
                    Text("Forgot Password")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .navigationBarTitle("Log In", displayMode: .large)
            .navigationBarItems(leading: Button(action: {
                // Back button action
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            })
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func makeTermsText() -> AttributedString {
            var text = AttributedString("I agree to the ")
            
            if let privacyURL = URL(string: "https://example.com/privacy") {
                var privacy = AttributedString("Privacy Policy")
                privacy.link = privacyURL
                privacy.foregroundColor = .blue
                privacy.underlineStyle = .single
                text += privacy
            }
            
            text += AttributedString(" and ")
            
            if let termsURL = URL(string: "https://example.com/terms") {
                var terms = AttributedString("User Agreement")
                terms.link = termsURL
                terms.foregroundColor = .blue
                terms.underlineStyle = .single
                text += terms
            }
            
            return text
        }
}

// Custom toggle style to match the checkbox in the design
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
