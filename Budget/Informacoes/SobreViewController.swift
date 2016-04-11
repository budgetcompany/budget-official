//
//  SobreViewController.swift
//  Budget
//
//  Created by Yuri Pereira on 4/11/16.
//  Copyright © 2016 Budget Company. All rights reserved.
//

import UIKit

class SobreViewController: UIViewController {
    
    @IBOutlet var btnSidebar:UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SidebarMenu.configMenu(self, sideBarMenu: btnSidebar)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
