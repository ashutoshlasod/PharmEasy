//
//  DetailViewController.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 08/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    class var instance : DetailViewController? {
        return UIStoryboard.main().instantiateViewController(withIdentifier: Constant.ID_DETAIL_VC) as? DetailViewController
    }
    
    var userInformation : DataModel?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        if let userID = self.userInformation?.id {
            self.userID.text = "\(Constant.USER_ID_LABEL)\(userID)"
        }
        if let firstName = self.userInformation?.firstName, let lastName = self.userInformation?.lastName {
            self.userName.text = "\(Constant.USER_NAME_LABEL)\(firstName) \(lastName)"
        }
        let thumbUrl = self.userInformation?.avatar ?? ""
        DispatchQueue.global(qos: .background).async {
            //Download image if not found in cache
            if let urlObject = URL.init(string: thumbUrl){
                do{
                    let data = try Data.init(contentsOf: urlObject)
                    if let resultImage = UIImage.init(data: data){
                        DispatchQueue.main.async {
                            self.userImage.image = resultImage
                        }
                    }
                } catch {
                    debugPrint(Constant.ERROR_DOWNLOADING_IMAGE)
                    DispatchQueue.main.async {
                        self.userImage.image = nil
                    }
                }
            }
        }
    }
}
