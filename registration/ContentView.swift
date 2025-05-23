//
//  ContentView.swift
//  registration
//
//  Created by Shaan on 19/05/25.
//

import SwiftUI


struct RadioButtonView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)

                Text(title)
                    .padding(.leading, 5)
            }
            .padding(6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
            .cornerRadius(8)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var selectedDate = Date()
    @State private var gender = "Male"
    @State private var bio = ""
    @State private var selectedOption = "Credit Card"
    @State private var showPhotoOptions = false

    let genderOptions = ["Male", "Female", "Other"]
    let paymentMethods = ["Credit Card", "PayPal", "UPI", "Net Banking"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .onTapGesture {
                                showPhotoOptions = true
                            }
                            .confirmationDialog("Choose an option", isPresented: $showPhotoOptions, titleVisibility: .visible) {
                                Button("Upload Photo") { /* Handle Upload */ }
                                Button("Take Photo") { /* Handle Camera */ }
                                Button("Cancel", role: .cancel) { }
                            }
                    }

                    // Username & Email
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    // Date Picker
                    DatePicker("Date Of Birth", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())

                    // Gender Dropdown
                    Picker("Gender", selection: $gender) {
                        ForEach(genderOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    // Radio Buttons Section
                    VStack {
                        Text("Select Payment Method")
                            .font(.headline)
                            .padding(.bottom, 5)

                        ForEach(paymentMethods, id: \.self) { method in
                            RadioButtonView(title: method, isSelected: selectedOption == method) {
                                selectedOption = method
                            }
                        }
                    }

                    // Comment above text area
                    Text("Comments:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Text Area (Enforcing 4-Line Limit)
                    TextEditor(text: $bio)
                        .frame(height: 80) // Adjusted for better screen fit
                        .border(Color.gray)
                        .onChange(of: bio) { newValue in
                            let lines = newValue.components(separatedBy: "\n")
                            if lines.count > 4 {
                                bio = lines.prefix(4).joined(separator: "\n")
                            }
                        }

                    // Register Button
                    Button("Register") {}
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Registration")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
