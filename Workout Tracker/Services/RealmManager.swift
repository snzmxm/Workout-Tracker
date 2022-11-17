//
//  RealmManager.swift
//  Workout Tracker
//
//  Created by SNZ on 08.11.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private init() {}
    let localRealm = try! Realm()

    // метод для сохранения в базу данных
    func saveWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    // метод для удаления
    func deleteWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    //при изменении данных обновляем базу данных
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
    }
    //for timer
    func updateSetsTimerWorkoutModel(model: WorkoutModel, sets: Int, timer: Int) {
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutTimer = timer
        }
    }

    func updateStatusWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            model.workoutStatus = true
        }
    }

    func saveUserModel(model: UserModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }

    func updateUserModel(model: UserModel) {

        let users = localRealm.objects(UserModel.self)

        try! localRealm.write {
            users[0].userFirstName = model.userFirstName
            users[0].userSecondName = model.userSecondName
            users[0].userHeight = model.userHeight
            users[0].userWeight = model.userWeight
            users[0].userTarget = model.userTarget
            users[0].userImage = model.userImage
        }
    }
}
