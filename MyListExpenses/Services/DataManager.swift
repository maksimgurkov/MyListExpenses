//
//  DataManager.swift
//  MyListExpenses
//
//  Created by Максим Гурков on 22.06.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private init() {}

    func createTempDataV2(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "Buzz") {

            let shoppingList = ListExpenses()
            shoppingList.name = "Машина"

            let milk = Expense()
            milk.name = "Масло"
            milk.sumExpenses = 1000

            shoppingList.listExpenses.append(milk)


            DispatchQueue.main.async {
                StorageManager.shared.save([shoppingList])
                UserDefaults.standard.set(true, forKey: "Buzz")
                completion()
            }
        }
    }
}
