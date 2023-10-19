//
//  RealmMigration.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 08.10.2023.
//

import RealmSwift

class RealmMigration {

    static func performMigration() {
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: RecipeRealmModel.className()) { oldObject, newObject in
//                        newObject!["instuctionsLabel"] = "",
//                        newObject!["instuctionsLabel"] = "",
//                        newObject!["instuctionsLabel"] = "",
//                        newObject!["instuctionsLabel"] = "",
                    }
                                               

                }
            })

        Realm.Configuration.defaultConfiguration = config

        do {
            _ = try Realm()
        } catch {
            // Обработайте ошибку инициализации Realm после миграции
            print("Failed to initialize Realm after migration: \(error)")
        }
    }
}
