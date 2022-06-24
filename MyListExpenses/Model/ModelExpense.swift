//
//  ModelExpense.swift
//  MyListExpenses
//
//  Created by Максим Гурков on 22.06.2022.
//

import Foundation
import RealmSwift

class ListExpenses: Object {
    @Persisted var name = ""
    @Persisted var date = Date()
    @Persisted var listExpenses = List<Expense>()
    
    func sumExpenses(test: List<Expense>) -> Int {
        var resultSum = 0
        for expense in test {
            resultSum += expense.sumExpenses
        }
        return resultSum
    }
}

class Expense: Object {
    @Persisted var name = ""
    @Persisted var sumExpenses = 0
    @Persisted var date = Date()
    @Persisted var isComplete = false
}
