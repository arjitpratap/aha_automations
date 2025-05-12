import SwiftUI

struct RegistrationView: View {
    @State private var selectedCountry = "United Kingdom"
    @State private var emailAddress = ""
    @State private var isAgreedToTerms = false
    @State private var showCountryPicker = false
    @Environment(\.presentationMode) var presentationMode
    
    var isValidEmail: Bool {
        let trimmed = emailAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.lowercased().hasSuffix("@gmail.com") && !trimmed.isEmpty
    }

    
    var body: some View {
        VStack(spacing: 0) {
            // Back button area
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 24) {
                
                Text("Register")
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                // Country Selection Button
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

                
                // Email Address TextField
                TextField("Email Address", text: $emailAddress)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                // Terms Checkbox
                HStack {
                    Button(action: {
                        isAgreedToTerms.toggle()
                    }) {
                        HStack {
                            Image(systemName: isAgreedToTerms ? "checkmark.square.fill" : "square")
                                .foregroundColor(.blue)
                            Text("I agree to the Privacy Policy and User Agreement")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                // Get Verification Code Button
                Button(action: {
                    // Action for getting verification code
                }) {
                    Text("Get Verification Code")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(isValidEmail ? Color.blue : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!isAgreedToTerms)
                .disabled(!isValidEmail)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
