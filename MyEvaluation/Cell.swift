//
//  Cell.swift
//  MyEvaluation
//
//  Created by الياسي on 01/05/2022.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var excellentLabel: UILabel!
   
    @IBOutlet weak var goodLabel: UILabel!
     
    @IBOutlet weak var weakLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func myEvaluation(_ MyEvaluation:MyEvaluationData)  {
        excellentLabel.text = "\(MyEvaluation.excellent ?? 0)"
        goodLabel.text = "\(MyEvaluation.good ?? 0)"
        weakLabel.text = "\(MyEvaluation.weak ?? 0)"
    }

}
