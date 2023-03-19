//
//  ProfilePersonalInformationView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

struct ProfilePersonalInformationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isDisabled: Bool = true
    @State private var tempInfo: UserHalfInfo
    @ObservedObject var profileVM: ProfileViewModel
    @State private var showInfoAlert: Bool = false
    init(tempInfo: UserHalfInfo, profileVM: ProfileViewModel){
        self._tempInfo = State(wrappedValue: profileVM.halfInfo)
        self._profileVM = ObservedObject(wrappedValue: profileVM)
    }
    
    var body: some View {
        VStack(spacing: 20){
            privateInfoSection
            goalsInfoSection
            saveButton
            Spacer()
        }
        .padding()
        .navigationTitle("Personal Information")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: tempInfo) { _ in
            isDisabled = false
        }
        .alert(alertMessage, isPresented: $showInfoAlert){
            Button("OK") {
                dismiss()
            }
        }
    }
}

struct ProfilePersonalInformationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfilePersonalInformationView(tempInfo: .init(weight: 0, gender: .male, age: 0, height: 0, activityLevel: .hight, goal: .gain), profileVM: ProfileViewModel())
        }
    }
}

extension ProfilePersonalInformationView{
    
    private var privateInfoSection: some View{
        HStack(spacing: 30){
            NumberTextField(
                value: Binding(get: {
                Double(tempInfo.age)
                }, set: {tempInfo.age = $0 >= 99 ? 99 : Int($0)}),
                            promt: "Age", label: "Age")
            
            NumberTextField(value: $tempInfo.weight, promt: "Weight", label: "Weight, kg")
            NumberTextField(value: $tempInfo.height, promt: "Height", label: "Height, cm")
        }
    }
    
    private var goalsInfoSection: some View{
        VStack(alignment: .leading, spacing: 20){
           
            Picker(selection: $tempInfo.goal) {
                ForEach(UserHalfInfo.GoalType.allCases, id: \.self){type in
                    Text(type.title)
                        .tag(type)
                }
            } label: {
                Text("Target")
                    .font(.headline)
            }
            .pickerStyle(.navigationLink)
            .listStyle(.plain)
            Divider()
            
            Picker(selection: $tempInfo.gender) {
                ForEach(UserHalfInfo.Gender.allCases, id: \.self){type in
                    Text(type.rawValue.capitalized)
                        .tag(type.rawValue)
                }
            } label: {
                Text("Gender")
                    .font(.headline)
            }
            .pickerStyle(.navigationLink)
            .listStyle(.plain)
            
            Divider()
            Picker(selection: $tempInfo.activityLevel) {
                ForEach(UserHalfInfo.ActivityLevel.allCases, id: \.self){type in
                    Text(type.title)
                        .tag(type)
                }
            } label: {
                Text("Activity level")
                    .font(.headline)
            }
            .pickerStyle(.navigationLink)
            .listStyle(.plain)
        }
        .foregroundColor(.primaryFont)
        .padding(.vertical)
    }
    
    private var saveButton: some View{
        Button {
            profileVM.saveInfo(tempInfo)
            showInfoAlert.toggle()
        } label: {
            Text("Save")
        }
        .buttonStyle(CapsuleButton())
        .disabled(isDisabled)
    }
    
    private var alertMessage: String{
        "You have made changes that affect your calorie allowance. Your new calorie allowance is \(profileVM.halfInfo.totalCallories.toCalories)."
    }
}


