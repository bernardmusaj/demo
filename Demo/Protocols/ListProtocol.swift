//
//  ListProtocol.swift
//  Demo
//
//  Created by Bernard Musaj on 10.4.21.
//

import Foundation

/// For non-selectable TableViews (if a TableView item is selected, nothing happens).
protocol ListProtocol {
    func getData(at: IndexPath) -> Codable
    func numberOfSections() -> Int
    func numberOfItems() -> Int
}
