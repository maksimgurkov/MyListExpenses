//
//  ExpensesTableViewController.swift
//  MyListExpenses
//
//  Created by Максим Гурков on 22.06.2022.
//

import UIKit
import RealmSwift

class ExpensesTableViewController: UITableViewController {
    
    var expense: ListExpenses!
    
    private var expenses: Results<Expense>!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = expense.name
        expenses = expense.listExpenses.filter("isComplete = false")
        setupNavigationBar()
    }
    
//    func test() -> Int {
//        for i in expenses {
//            i.sumExpenses
//        }
//    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(newExpense))
    }
    
    @objc private func newExpense() {
        alertNewExpense()
    }
    
    private func alertNewExpense() {
        let alert = UIAlertController(
            title: "Внимание",
            message: "Добавить новый расход, введите название расхода и сумму",
            preferredStyle: .alert)
        let newExpenseActive = UIAlertAction(
            title: "Добавить",
            style: .default) { _ in
                guard let nameExpense = alert.textFields?.first?.text, !nameExpense.isEmpty else { return }
                guard let sumExpense = alert.textFields?.last?.text, !sumExpense.isEmpty else { return }
                    let expense1 = Expense()
                    expense1.name = nameExpense
                    expense1.sumExpenses = Int(sumExpense) ?? 0
                StorageManager.shared.saveExpense(self.expense, expensesList: expense1)
                self.tableView.insertRows(at: [IndexPath(row: self.expenses.count - 1, section: 0)], with: .automatic)
            }
        let cancelAction = UIAlertAction(title: "Назад", style: .destructive)
        
        alert.addAction(newExpenseActive)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "Введите имя расхода"
        }
        alert.addTextField { textFeld in
            textFeld.placeholder = "Введите сумму"
        }
        present(alert, animated: true)
    }
    
}
    
extension ExpensesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expenses.count != 0 {
            return expenses.count
        }
        return 0
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
        let expense = expenses[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = expense.name
        content.secondaryText = "\(expense.sumExpenses)"
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let expense = expenses[indexPath.row]
            StorageManager.shared.deleteExpense(expense)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
