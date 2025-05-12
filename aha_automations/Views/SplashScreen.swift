//
//  SplashScreen.swift
//  aha_automations
//
//  Created by Arjit Pratap Singh Chauhan on 12/05/25.
//

import SwiftUI

struct SplashScreen: View {

    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            // App Title Section
            Image("aha_main")
                .resizable()
                .scaledToFill()
                .padding(.horizontal,20)
                .frame(width: .infinity, height: 300) // Adjust as needed
            
            // Buttons Section
            VStack(spacing: 16) {
                // Sign Up Button
                NavigationLink(destination: RegistrationView()) {
                    Text("Sign Up")
                        .font(.system(size: 18, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50) // Fixed height for button
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                NavigationLink(destination: LoginView()) {
                    Text("Log In")
                        .font(.system(size: 18, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.black))
    }

}

