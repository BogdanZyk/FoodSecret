//
//  HealthKitViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 20.03.2023.
//

import Foundation
import HealthKit
import SwiftUI

class HealthKitViewModel: ObservableObject{
    
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userStepCount = "0"
    @Published var callories = "0"
    @AppStorage("isSetUpHealthRequest") var isSetUpHealth = false
    
    init(){
        self.fetchHealfData(Date.now)
    }
    
    
    func healthRequest(for date: Date) {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            DispatchQueue.main.async {
                self.isSetUpHealth = true
            }
            self.fetchHealfData(date)
        }
    }
    
    func fetchHealfData(_ date: Date) {
        healthKitManager.readStepCount(for: date, healthStore: healthStore) { step in
            DispatchQueue.main.async {
                self.userStepCount = String(format: "%.0f", step)
            }
        }
        healthKitManager.getActivity(for: date, healthStore: healthStore) { callories in
            DispatchQueue.main.async {
                self.callories = String(format: "%.0f", callories)
            }
        }
    }
    
//    func changeAuthorizationStatus() {
//
//
//        DispatchQueue.main.async {
//
//            let satuses = self.healthKitManager.getAuthorizationStatus(healthStore: self.healthStore)
//
//            switch satuses.activityStatus{
//            case .notDetermined, .sharingDenied:
//                self.isAuthorizedActivity = false
//                print("1, notDetermined, .sharingDenied")
//            case .sharingAuthorized:
//                self.isAuthorizedActivity = true
//            @unknown default:
//                self.isAuthorizedActivity = false
//            }
//
//            switch satuses.stepStatus{
//            case .notDetermined, .sharingDenied:
//                print("2, notDetermined, .sharingDenied")
//                self.isAuthorizedStep = false
//            case .sharingAuthorized:
//                self.isAuthorizedStep = true
//            @unknown default:
//                self.isAuthorizedStep = false
//            }
//            //self.isAuthorizedStep = true
//        }
//    }
}
