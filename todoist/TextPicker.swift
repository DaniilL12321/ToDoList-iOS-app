//
//  TextPicker.swift
//  todoist
//
//  Created by Daniil on 13.08.2023.
//

import UIKit

class TextPicker {
    
    static let defaultPicker = TextPicker()
    
    func getText(viewController: UIViewController, complition: @escaping (_ text: String) -> ()) {
        let alertController = UIAlertController(title: "Введите задачу:", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Ваша задача..."
        }
        
        let actionOk = UIAlertAction(title: "Добавить прекрасную задачу", style: .default) { action in
            let text = alertController.textFields![0].text!
            complition(text)
        }
        
        let actionCancel = UIAlertAction(title: "Отмена, пойду бездельничать", style: .cancel)
        
        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)
        
        viewController.present(alertController, animated: true)
    }
}
