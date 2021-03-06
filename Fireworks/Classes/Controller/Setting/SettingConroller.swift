//
//  SettingConroller.swift
//  Mineral
//
//  Created by Ricky on 2017/3/16.
//  Copyright © 2017年 safetysafetys. All rights reserved.
//

import UIKit

class SettingConroller: BaseViewController {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var lbCache: UILabel!
    var navBarHairlineImageView :UIImageView!
    override func viewDidLoad() {
        setNavagation("设置")
       
//      self.navigationController?.navigationBar.subviews[0].removeFromSuperview()//去掉
//        navBarHairlineImageView = findHairlineImageViewUnder(self.navigationController?.navigationBar.bac)
        initView()
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.navBarHairlineImageView.hidden = true
        //设置navigationBar背景
        self.navigationController?.navigationBar
            .setBackgroundImage(UIImage(named: "head_transparent"), forBarMetrics: .Default)
        //设置navigationBar  黑线背景
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "head_transparent")
    }
    
    override func viewWillDisappear(animated: Bool) {
//        self.navBarHairlineImageView.hidden = false
    }
    
    func initView(){
        if AppTools.isExisNSUserDefaultsKey("userName"){
            lbName.text=AppTools.loadNSUserDefaultsValue("userName") as? String
        }
//      lbVersion.text = "V"+getVersion()
      lbCache.text = "已使用"+String(self.fileSizeOfCache())+"M"
    
    }
    
    /**
     隐藏导航底部黑线
     
     - parameter view: self.navigationController?.navigationBar
     
     - returns: 底部线的UIImageView
     */
    func findHairlineImageViewUnder(view : UIView)->UIImageView!{
        
        if(view .isKindOfClass(UIImageView) && view.bounds.size.height <= 1.0 ){
            
            return view as! UIImageView
        }
        for subview in view.subviews {
            
            let imageView = self .findHairlineImageViewUnder(subview)
            
            if (imageView != nil) {
                return imageView
            }
        }
        return nil
    }
    
    @IBAction func back(sender: AnyObject) {
        self.lastNavigationPage()
    }
    
    @IBAction func cancell(sender: AnyObject) {
        self.alertNotice("提示", message: NOTICE_CANCELL, handler: {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    @IBAction func clean(sender: AnyObject) {
        self.alert("确定清空缓存吗？") {
            self.clearCache()
            self.lbCache.text = "已使用0M"
        }
    }
    
    
    @IBAction func changPwd(sender: AnyObject) {
        self.navigationController?.pushViewController(PwdSettingController(), animated: true)
    }
    
}
