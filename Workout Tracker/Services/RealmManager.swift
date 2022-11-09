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
}
