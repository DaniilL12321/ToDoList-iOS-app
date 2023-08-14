//
//  ViewController.swift
//  todoist
//
//  Created by Daniil on 13.08.2023.
//

import UIKit

class ViewController: UIViewController {
    // оутлет на редактирование внешки tableview кодом
    @IBOutlet weak var tableView: UITableView!
    // обозначение переменных
    var model = Model()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    // вызов текст пикера из TextPicker.swift, для показа алерт контроллера на получение новой задачи
    @IBAction func Add(_ sender: Any) {
        TextPicker.defaultPicker.getText(viewController: self) { text in
            self.model.addItem(title: text)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        
    }
    
    
    
    
}
//
extension ViewController: UITableViewDataSource {
    // не понимаю что это, но скопировано из источника в UIKit
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // подсчёт количества названий в списке типо
        model.items.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = UIListContentConfiguration.cell()
        configuration.text = model.items[indexPath.row].title
        
        configuration.secondaryText = model.items[indexPath.row].date.formatted(date: .complete, time: .shortened)
        
        cell.contentConfiguration = configuration
        
        cell.accessoryType = model.items[indexPath.row].isCompleted ? .checkmark : .none
        
        return cell
    }
}

// Удаление строк и переименовывание
extension ViewController: UITableViewDelegate {
    // Переименовывание
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Rename") { _, _, completion in
            TextPickerRename.defaultPickerRename.getText(viewController: self) { text in
                self.model.renameItem(atIndex: indexPath.row, newTitle: text)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }

            tableView.reloadRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    // Удаление
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, completion in
            self.model.deleteItem(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.toogleItem(atIndex: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
