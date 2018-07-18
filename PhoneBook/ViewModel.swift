//
//  ViewModel.swift
//  PhoneBook
//
//  Created by junwoo on 18/07/2018.
//  Copyright © 2018 samchon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ViewModel {
  
  var phoneBook: [String:String] = [:]
  var searchText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
  
  var items: Observable<[String:String]> {
    
    return searchText.asObservable()
      .map { query in
        return self.filteredBook(query)
    }
  }
  
  private func filteredBook(_ query: String) -> [String:String] {
    var filteredBook = [String:String]()
    guard query != "" else { return phoneBook }
    for (key, value) in phoneBook {
      if key.hasPrefix(query.lowercased()) {
        filteredBook.updateValue(value, forKey: key)
      }
    }
    return filteredBook
  }
}
