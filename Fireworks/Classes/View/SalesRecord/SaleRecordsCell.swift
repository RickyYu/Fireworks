//
//  SaleRecordsCell.swift
//  Mineral
//
//  Created by Ricky on 2017/3/17.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class SaleRecordsCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var  model: SaleRecordModel?
        {
        didSet{
            if let art = model {
                var catonStr:String = ""
                var numStr:String = ""
                // 设置数据
                if art.productCartons != "" {
                    catonStr = "\(art.productCartons)箱"
                }
                
                if art.productNumber != "" {
                   numStr = "\(art.productNumber)个"
                }
                self.name?.text = ("\(art.name)购买了\(catonStr)\(numStr)\((art.productName))")
                self.time?.text = art.payTime
                self.content.text = "联系电话：\(art.phone)"

            }
        }
    }
}
