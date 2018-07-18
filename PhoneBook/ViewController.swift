//
//  ViewController.swift
//  PhoneBook
//
//  Created by junwoo on 18/07/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  private let bag = DisposeBag()
  private var viewModel = ViewModel()
  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return table
  }()
  
  private lazy var inputField: UITextField = {
    let view = UITextField()
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 0.5
    view.placeholder = "enter name"
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.phoneBook.updateValue("1", forKey: "aaa")
    viewModel.phoneBook.updateValue("2", forKey: "bobby")
    viewModel.phoneBook.updateValue("3", forKey: "charlie")
    
    setupUI()
    bind()
  }
  
  private func setupUI() {
    view.addSubview(tableView)
    view.addSubview(inputField)
    
    inputField.snp.makeConstraints {
      $0.top.equalToSuperview().offset(100)
      $0.left.equalToSuperview().offset(50)
      $0.right.equalToSuperview().offset(-50)
      $0.height.equalTo(50)
    }
    tableView.snp.makeConstraints {
      $0.top.equalTo(inputField.snp.bottom).offset(50)
      $0.left.bottom.right.equalToSuperview()
    }
  }
  
  private func bind() {
    
    inputField.rx.text.orEmpty
      .bind(to: viewModel.searchText)
      .disposed(by: bag)
    
    viewModel.items
      .bind(to: tableView.rx.items) {
        (tableView: UITableView, index: Int, element: (String, String)) in
      let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
      cell.textLabel?.text = element.0
      return cell
      }
      .disposed(by: bag)
  }
}
