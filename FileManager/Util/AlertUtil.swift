//
//  AlertUtil.swift
//  FileManager
//
//  Created by 伊藤明孝 on 2024/01/08.
//

import Foundation
import UIKit
struct AlertUtil{
    static let shared = AlertUtil()
    
    public func showSaveWithTextAlert(vc: UIViewController, completion: @escaping(_ text: String) -> Void){
        let avc = UIAlertController(title: "Save", message: "Add new item", preferredStyle: .alert)
               avc.addTextField()
               avc.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action  in
                   if let text = avc.textFields?.first?.text{
                       completion(text)
                   }
               }))
               vc.present(avc, animated: true, completion: nil)
    }
}
