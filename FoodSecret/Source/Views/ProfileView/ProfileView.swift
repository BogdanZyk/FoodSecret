//
//  ProfileView.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 17.03.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var profileLink: ProfileLink?
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 26) {
                userProfileSection
                infosettings
            }
            .padding()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    Text("Settings")
                        .navigationTitle("Settings")
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
        .navigationDestination(for: ProfileLink.self) { type in
            switch type{
            case .personalInfo:
                ProfilePersonalInformationView(tempInfo: viewModel.halfInfo, profileVM: viewModel)
            case .water:
                WaterSettingsView(tempWater: viewModel.halfInfo.waterInfo, profileVM: viewModel)
            case .diet:
                Text("TO DO DIET INFO")
            }
        }
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
    
    
    
    private var userProfileSection: some View{
        
        GroupBox {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16){
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color(.systemGray3))
                    VStack(alignment: .leading, spacing: 2){
                        Text("Myself")
                            .font(.title3.bold())
                        Text("Age: \(viewModel.halfInfo.age)")
                            .font(.subheadline.weight(.medium))
                    }
                    
                }
                Divider().background(Color(.systemGray))
                rowView(title: "Weight", value: "\(viewModel.halfInfo.weight) kg")
                rowView(title: "Target", value: "\(viewModel.halfInfo.goal.title)")
                rowView(title: "Diet", value: "Vegan")
            }
        }
    }
    
    private var infosettings: some View{
        VStack(alignment: .leading, spacing: 16){
            Text("Personalized settings".uppercased())
                .font(.headline.bold())
                .foregroundColor(.secondary)
            GroupBox {
                VStack(spacing: 16) {
                    ForEach(ProfileLink.allCases, id:\.self) { type in
                        linkView(type)
                        if type != .water{
                            Divider()
                        }
                    }
                }
            }
        }
    }
    
//    private var infoSection: some View{
//        Group{
//            rowView(title: "Age", value: "\(viewModel.halfInfo.age)")
//            rowView(title: "Height", value: "\(viewModel.halfInfo.height) cm")
//            rowView(title: "Weight", value: "\(viewModel.halfInfo.weight) kg")
//            rowView(title: "Gender", value: "\(viewModel.halfInfo.gender.rawValue.capitalized)")
//            rowView(title: "Goal", value: "\(viewModel.halfInfo.goal.title)")
//            rowView(title: "Activity level", value: "\(viewModel.halfInfo.activityLevel.title)")
//            rowView(title: "Callories", value: "\(viewModel.halfInfo.totalCallories.toCalories)")
//        }
//    }
    
    
    private func rowView(title: String, value: String) -> some View{
        HStack {
            Text("\(title):")
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
        .font(.headline)
    }
    
    
    private func linkView(_ type: ProfileLink) -> some View{
        NavigationLink(value: type) {
            HStack(spacing: 16){
                Image(systemName: type.image)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(type.rawValue)
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .foregroundColor(.primaryFont)
            .padding(.vertical, 6)
        }
    }
    
    enum ProfileLink: String, CaseIterable{
        
        case personalInfo = "Personal information"
        case diet = "Dietary features"
        case water = "Water consumption"
        
        var image: String{
            switch self {
                
            case .personalInfo: return "person.fill"
            case .diet: return "takeoutbag.and.cup.and.straw.fill"
            case .water: return "drop.fill"
            }
        }
    }
}
