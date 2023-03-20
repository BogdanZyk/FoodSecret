//
//  HealthKitViewModel.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 20.03.2023.
//

import Foundation
import HealthKit

class HealthKitViewModel: ObservableObject{
    
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    @Published var userStepCount = ""
    @Published var isAuthorized = false
    
    init(){
        changeAuthorizationStatus()
    }
    
    
    func healthRequest(for date: Date) {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday(date)
        }
    }
    
    func readStepsTakenToday(_ date: Date) {
        guard isAuthorized else { return }
        healthKitManager.readStepCount(for: date, healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
                    self.userStepCount = String(format: "%.0f", step)
                }
            }
        }
    }
    
    func changeAuthorizationStatus() {
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        DispatchQueue.main.async {
            switch status {
            case .notDetermined, .sharingDenied:
                self.isAuthorized = false
            case .sharingAuthorized:
                self.isAuthorized = true
            @unknown default:
                self.isAuthorized = false
            }
        }
    }
}
