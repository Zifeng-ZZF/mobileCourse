//
//  MainView.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/31.
//

import Foundation
import UIKit

extension MainViewController {
    func setUpTableView() {
        fileTableView.translatesAutoresizingMaskIntoConstraints = false
        fileTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fileTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        fileTableView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        fileTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    }
    
    func setUpSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setUpButtonsMenu() {
        importFileBtn.translatesAutoresizingMaskIntoConstraints = false
        importFileBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        importFileBtn.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        importFileBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        importFileBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        sortingBtn.translatesAutoresizingMaskIntoConstraints = false
        sortingBtn.rightAnchor.constraint(equalTo: importFileBtn.leftAnchor, constant: -5).isActive = true
        sortingBtn.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        sortingBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortingBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        filterBtn.translatesAutoresizingMaskIntoConstraints = false
        filterBtn.rightAnchor.constraint(equalTo: sortingBtn.leftAnchor, constant: -5).isActive = true
        filterBtn.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        filterBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        filterBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
