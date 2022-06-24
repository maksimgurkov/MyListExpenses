//
//  ExpenseListTableViewCell.swift
//  MyListExpenses
//
//  Created by Максим Гурков on 23.06.2022.
//

import UIKit

class ExpenseListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameExpenseLabel: UILabel!
    @IBOutlet weak var sumExpenseLabel: UILabel!
    @IBOutlet weak var dateExpenseLabel: UILabel!
    @IBOutlet weak var countExpenseLabel: UILabel!
    
    @IBOutlet weak var colorViewExpense: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorViewExpense.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
