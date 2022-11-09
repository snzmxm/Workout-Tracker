//
//  WorkoutModel.swift
//  Workout Tracker
//
//  Created by SNZ on 08.11.2022.
//

import Foundation
import RealmSwift

class WorkoutModel: Object {

    @Persisted var workoutDate: Date
    @Persisted var workoutNumberOfDay: Int = 0
    @Persisted var workoutName: String = "Unknown"
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int = 0
    @Persisted var workoutReps: Int = 0
    @Persisted var workoutTimer: Int = 0
    @Persisted var workoutImage: Date?
    @Persisted var workoutStatus: Bool = false
}