//
//  StorageManager.swift
//  MyListExpenses
//
//  Created by Максим Гурков on 22.06.2022.
//

import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    init () {}
    
    func save(_ expenses: [ListExpenses]) {
        try! realm.write{
            realm.add(expenses)
        }
    }
    
    func save(_ expense: ListExpenses) {
        write {
            realm.add(expense)
        }
    }
    
    func delete(_ expense: ListExpenses) {
        write {
            realm.delete(expense.listExpenses)
            realm.delete(expense)
        }
    }
    
    func deleteExpense(_ expense: Expense) {
        write {
            realm.delete(expense)
        }
    }
    
    func saveExpense(_ expense: ListExpenses, expensesList: Expense) {
        write {
            expense.listExpenses.append(expensesList)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
    
    
}
