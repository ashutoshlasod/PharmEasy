//
//  ViewControllerTableViewCell.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 08/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import Foundation
import UIKit

class HomeCell: UITableViewCell {
    
    @objc dynamic var userInformation : DataModel? = nil
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var acitvityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.showLoader(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addObserver(self, forKeyPath: #keyPath(HomeCell.userInformation), options: [.old, .new], context: nil)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(HomeCell.userInformation) {
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
                                self.showLoader(false)
                            }
                        }
                    } catch {
                        debugPrint(Constant.ERROR_DOWNLOADING_IMAGE)
                        DispatchQueue.main.async {
                            self.userImage.image = nil
                            self.showLoader(false)
                        }
                    }
                }
            }
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: #keyPath(HomeCell.userInformation))
    }
    
    func showLoader(_ bool : Bool){
        if bool{
            self.acitvityIndicator.startAnimating()
            self.acitvityIndicator.isHidden = false
        }else{
            self.acitvityIndicator.stopAnimating()
            self.acitvityIndicator.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userImage.image = nil
        self.showLoader(true)
    }
}
