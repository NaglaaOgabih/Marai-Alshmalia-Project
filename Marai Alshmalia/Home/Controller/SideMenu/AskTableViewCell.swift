//
//  AskTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 27/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
protocol showAnswerDelegate {
    func answerTableViewCellWith(index:Int)
}
class AskTableViewCell: UITableViewCell {
    
    var index = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answeStack: UIStackView!
    @IBOutlet weak var answeLabel: UILabel!
    @IBOutlet weak var showBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        showBtn.setImage(UIImage(named: "drop"), for: .normal)
        answeStack.isHidden = true
//        self.showBtn.addTarget(self, action: #selector(showBtnPressed(_:)), for: .touchUpInside)

    }
    var delegate : showAnswerDelegate?

    var switchAnswer : Bool = false
//        var showAction : (()->())?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setDataToView(model:Ask) {
        questionLabel.text = model.ask
        answeLabel.text = model.answer
        
        if model.isExpanded == true{
            showBtn.setImage(UIImage(named: "dropup"), for: .normal)
            answeStack.isHidden = false
        }else{
            showBtn.setImage(UIImage(named: "drop"), for: .normal)
            answeStack.isHidden = true
        }
    }
//    @IBAction func showBtnPressed(_ sender: Any) {
//            self.delegate?.answerTableViewCellWith(index: index)
//      }
}
