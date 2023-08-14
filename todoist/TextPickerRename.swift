//
//  TextPicker.swift
//  todoist
//
//  Created by Daniil on 13.08.2023.
//

import UIKit

class TextPickerRename {
    
    static let defaultPickerRename = TextPickerRename()
    
    func getText(viewController: UIViewController, complition: @escaping (_ text: String) -> ()) {
        let alertController = UIAlertController(title: "Переименуйте задачу:", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Переименованная задача"
        }
        
        let actionOk = UIAlertAction(title: "Исправить прекрасную задачу!", style: .default) { action in
            let text = alertController.textFields![0].text!
            complition(text)
        }
        
        let actionCancel = UIAlertAction(title: "Отмена, и так сойдёт", style: .cancel)
        
        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)
        
        viewController.present(alertController, animated: true)
    }
}
