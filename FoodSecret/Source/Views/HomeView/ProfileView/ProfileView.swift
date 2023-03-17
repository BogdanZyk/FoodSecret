//
//  ProfileView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        List{
            Section {
                infoSection
            } header: {
                HStack {
                    Text("Personal information")
                    Spacer()
                    
                    NavigationLink {
                        EditInfoView(tempInfo: viewModel.halfInfo, profileVM: viewModel)
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}

extension ProfileView{
    
    private var infoSection: some View{
        Group{
            rowView(title: "Age", value: "\(viewModel.halfInfo.age)")
            rowView(title: "Height", value: "\(viewModel.halfInfo.height) cm")
            rowView(title: "Weight", value: "\(viewModel.halfInfo.weight) kg")
            rowView(title: "Gender", value: "\(viewModel.halfInfo.gender.rawValue.capitalized)")
            rowView(title: "Goal", value: "\(viewModel.halfInfo.goal.title)")
            rowView(title: "Activity level", value: "\(viewModel.halfInfo.activityLevel.title)")
            rowView(title: "Callories", value: "\(viewModel.halfInfo.totalCallories.toCalories)")
        }
    }
    
//    private var
    
    private func rowView(title: String, value: String) -> some View{
        HStack {
            Text("\(title):")
                .foregroundColor(.secondary)
            Text(value)
        }
        .padding(.vertical, 10)
        .font(.headline)
    }
}
