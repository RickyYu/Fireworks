//
//  MainController.swift
//  Mineral
//
//  Created by Ricky on 2017/3/9.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit
class MainController: BaseViewController{

    @IBOutlet weak var totalYearNum: UILabel!
    @IBOutlet weak var firstSeasonNum: UILabel!
    @IBOutlet weak var secondSeasonNum: UILabel!
    @IBOutlet weak var thirdSeasonNum: UILabel!
    @IBOutlet weak var fouthSeasonNum: UILabel!
    

    @IBOutlet weak var totalMonthNum: UILabel!
    @IBOutlet weak var firstWeekNum: UILabel!
    @IBOutlet weak var secondWeekNum: UILabel!
    @IBOutlet weak var thirdWeekNum: UILabel!
    @IBOutlet weak var fourhWeekNum: UILabel!
    
    var numSeason1:Int = 0
    var numSeason2:Int = 0
    var numSeason3:Int = 0
    var numSeason4:Int = 0
    
    var cartonSeason1:Int = 0
    var cartonSeason2:Int = 0
    var cartonSeason3:Int = 0
    var cartonSeason4:Int = 0
    
    
    var numMonth1:Int = 0
    var numMonth2:Int = 0
    var numMonth3:Int = 0
    var numMonth4:Int = 0
    
    var cartonMonth1:Int = 0
    var cartonMonth2:Int = 0
    var cartonMonth3:Int = 0
    var cartonMonth4:Int = 0
    


    
    
    @IBOutlet weak var yearCarton: UILabel!
    @IBOutlet weak var yearNum: UILabel!
    
    @IBOutlet weak var monthCarton: UILabel!
    @IBOutlet weak var monthNum: UILabel!

    var models = [SalesCountModel]()
    // 当前页
    var currentPage : Int = 0  //加载更多时候+PAGE_SIZE
    //总条数
    var totalCount : Int = 0
    // 是否加载更多
    private var toLoadMore = false
    override func viewDidLoad() {
        setNavagation("")
       self.navigationController?.navigationBar.hidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "set_head.png"), forBarMetrics: .Default)

        
        
        yearCarton.addOnClickListener(self, action: #selector(setSeasonData))
        yearNum.addOnClickListener(self, action: #selector(setSeasonData))
        
        monthCarton.addOnClickListener(self, action: #selector(setSeasonData))
        monthNum.addOnClickListener(self, action: #selector(setSeasonData))
        
    }
    

    
    override func viewWillAppear(animated: Bool) {
       self.navigationController?.navigationBar.hidden = true
        getRecords()
    }
    
    func getRecords(){

        
        var parameters = [String : AnyObject]()
        parameters["type"] = TYPE_CODE
        NetworkTool.sharedTools.getRecordCount(parameters) { (data, error) in
            if error == nil{
                self.models = data
                 self.setData(self.models)
            }else{
                if error == NOTICE_SECURITY_NAME {
                    self.toLogin()
                }else{
                    self.showHint(error, duration: 2.0, yOffset: 2.0)
                }
            }
        }
        
    }
    
    var numSeasonTotal:Int = 0
    var numMonthTotal:Int  = 0
    var cartonSeasonTotal:Int = 0
    var cartonMonthTotal:Int = 0
    
    func setData(data : [SalesCountModel]!){
        for model in data {
            if model.dataType == "season1" {
                self.numSeason1 = model.num
                self.cartonSeason1 = model.carton
                if isCarton {
                 self.firstSeasonNum.text = "第一季度：\(self.cartonSeason1)"
                }else{
                 self.firstSeasonNum.text = "第一季度：\(self.numSeason1)"
                }
               
            }else if model.dataType == "season2" {
                self.numSeason2 = model.num
                self.cartonSeason2 = model.carton
                if isCarton {
                    self.secondSeasonNum.text = "第二季度：\(self.cartonSeason2)"
                }else{
                     self.secondSeasonNum.text = "第二季度：\(self.numSeason2)"
                }
                
            }else if model.dataType == "season3" {
                self.cartonSeason3 = model.carton
                self.numSeason3 = model.num
                if isCarton {
                   self.thirdSeasonNum.text = "第三季度：\(self.cartonSeason3)"
                }else{
                    self.thirdSeasonNum.text = "第三季度：\(self.numSeason3)"
                }
                
            }else if model.dataType == "season4" {
                self.cartonSeason4 = model.carton
                self.numSeason4 = model.num
                if isCarton {
                    self.fouthSeasonNum.text = "第四季度：\(self.cartonSeason3)"
                }else{
                    self.fouthSeasonNum.text = "第四季度：\(self.numSeason3)"
                }
            }else if model.dataType == "month1" {
                self.cartonMonth1 = model.carton
                self.numMonth1 = model.num
                if isCarton {
                 self.firstWeekNum.text = "第一周：\(self.cartonMonth1)"
                }else{
                self.firstWeekNum.text = "第一周：\(self.numMonth1)"
                }
                
            }else if model.dataType == "month2" {
                self.cartonMonth2 = model.carton
                self.numMonth2 = model.num
                if isCarton {
                 self.secondWeekNum.text = "第二周：\(self.cartonMonth2)"
                }else {
                 self.secondWeekNum.text = "第二周：\(self.numMonth2)"
                }
            }else if model.dataType == "month3" {
                self.cartonMonth3 = model.carton
                self.numMonth3 = model.num
                if isCarton {
                self.thirdWeekNum.text = "第三周：\(self.cartonMonth3)"
                }else {
                self.thirdWeekNum.text = "第三周：\(self.numMonth3)"
                }
            }else if model.dataType == "month4" {
                self.cartonMonth4 = model.carton
                self.numMonth4 = model.num
                if isCarton {
                self.fourhWeekNum.text = "第四周：\(self.cartonMonth4)"
                }else {
                self.fourhWeekNum.text = "第四周：\(self.numMonth4)"
                }
                
            }
        }
        
        if isCarton {
            cartonSeasonTotal = self.cartonSeason1+self.cartonSeason2+self.cartonSeason3+self.cartonSeason4
            cartonMonthTotal = self.cartonMonth1+self.cartonMonth2+self.cartonMonth3+self.cartonMonth4
            self.totalYearNum.text = String(cartonSeasonTotal)
            self.totalMonthNum.text = String(cartonMonthTotal)
        }else{
            
            numSeasonTotal = self.numSeason1+self.numSeason2+self.numSeason3+self.numSeason4
            numMonthTotal = self.numMonth1+self.numMonth2+self.numMonth3+self.numMonth4
            self.totalYearNum.text = String(numSeasonTotal)
            self.totalMonthNum.text = String(numMonthTotal)
        }
        
    }
    
    var isCarton:Bool = true
    func setSeasonData(){
        isCarton = !isCarton
        self.setData(self.models)
        if isCarton {
            yearCarton.textColor = UIColor.redColor()
            monthCarton.textColor = UIColor.redColor()
            yearNum.textColor = UIColor.blackColor()
            monthNum.textColor = UIColor.blackColor()
        }else {
            yearCarton.textColor = UIColor.blackColor()
            monthCarton.textColor = UIColor.blackColor()
            yearNum.textColor = UIColor.redColor()
            monthNum.textColor = UIColor.redColor()
        }
        
        
        
    }
//    func setMonthData(){
//        isCarton = !isCarton
//        self.setData(self.models)
//        if isCarton {
//            changeYearNum.text  = "本年度销售数量(箱)"
//            changeMonthNum.text  = "本月度销售数量(箱)"
//        }else {
//            changeYearNum.text  = "本年度销售数量(个)"
//            changeMonthNum.text  = "本月度销售数量(个)"
//        }
//    }

    
    
}

