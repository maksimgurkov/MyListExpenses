//
//  MyListExpenseTableViewController.swift
//  MyListExpenses
//
//  Created by Максим Гурков on 22.06.2022.
//

import UIKit
import RealmSwift

class MyListExpenseTableViewController: UITableViewController {
    
    private var expensesList: Results<ListExpenses>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesList = StorageManager.shared.realm.objects(ListExpenses.self)
        setupNavigationBar()
        createTempData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        title = "Список расходов"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(newMyExpenses)
        )
    }
    
    private func dateFormat(expense: ListExpenses) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        let weekDay = dateFormatter.string(from: expense.date)
        return weekDay
    }
    
    @objc private func newMyExpenses() {
        alertNewExpense()
    }
    
    //MARK: - AlertControler
    
    private func alertNewExpense() {
        let alert = UIAlertController(
            title: "Внимание.",
            message: "Добавьте имя вашего расхода",
            preferredStyle: .alert)
        let newMyExpenseAction = UIAlertAction(
            title: "Добавить",
            style: .default) { _ in
                guard let newNameExpense = alert.textFields?.first?.text, !newNameExpense.isEmpty else {return}
                    let expense = ListExpenses()
                    expense.name = newNameExpense
                StorageManager.shared.save(expense)
                self.tableView.insertRows(
                    at: [IndexPath(row: self.expensesList.count - 1, section: 0)],
                    with: .automatic)
            }
        
        let cancelAction = UIAlertAction(
            title: "Назад",
            style: .destructive)
        alert.addAction(newMyExpenseAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "Имя расхода"
        }
        present(alert, animated: true)
    }
    
    private func createTempData() {
        DataManager.shared.createTempDataV2 {
            self.tableView.reloadData()
        }
    }
    
    
}
// MARK: - TableViewController

extension MyListExpenseTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expensesList.count != 0 {
        return expensesList.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ExpenseListTableViewCell
        let expense = expensesList[indexPath.row]
        
        cell.nameExpenseLabel.text = expense.name
        cell.sumExpenseLabel.text = "\(expense.sumExpenses(test: expense.listExpenses)) р."
        cell.dateExpenseLabel.text = dateFormat(expense: expense)
        cell.countExpenseLabel.text = "Всего внесенных расходов \(expense.listExpenses.count)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let expense = expensesList[indexPath.row]
        
        if editingStyle == .delete {
            StorageManager.shared.delete(expense)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let expensesVC = segue.destination as? ExpensesTableViewController else { return }
        let expense = expensesList[indexPath.row]
        expensesVC.expense = expense
    }
    

}
