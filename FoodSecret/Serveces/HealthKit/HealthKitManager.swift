//
//  HealthKitManager.swift
//  FoodSecret
//
//  Created by Bogdan Zykov on 20.03.2023.
//

import Foundation
import HealthKit

class HealthKitManager{
 
    let healfTypes = [
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.activitySummaryType()
    ]
    
    
    func setUpHealthRequest(healthStore: HKHealthStore, readSteps: @escaping () -> Void) {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore.requestAuthorization(toShare: [], read: Set(healfTypes)) { success, error in
                if success {
                    readSteps()
                } else if error != nil {
                    // handle error here
                }
            }
        }
    }
    
    func getAuthorizationStatus(healthStore: HKHealthStore) -> (stepStatus: HKAuthorizationStatus, activityStatus: HKAuthorizationStatus){
        
        let stepStatus = healthStore.authorizationStatus(for: healfTypes[0])
        let activityStatus = healthStore.authorizationStatus(for: healfTypes[1])
    
        return (stepStatus, activityStatus)
    }
    
    
    func readStepCount(for date: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void) {
        guard let stepQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }

        let startOfDay = date.noon
        let dayAfter = date.dayAfter

        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: dayAfter, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in

            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        
        healthStore.execute(query)
        
    }
    
    func getActivity(for date: Date, healthStore: HKHealthStore, completion: @escaping (Double) -> Void){
        
        let startOfDay = date.noon
        let dayAfter = date.dayAfter
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: dayAfter, options: .strictStartDate)
        let query = HKActivitySummaryQuery(predicate: predicate) { (query, summaries, error) in
            guard let sum = summaries else {
                completion(.zero)
                return
            }
            let calories = sum.compactMap({$0.activeEnergyBurned.doubleValue(for:.largeCalorie())})
                .reduce(0.0, +)
            
            completion(calories)
            
        }
        healthStore.execute(query)
    }
    
}
