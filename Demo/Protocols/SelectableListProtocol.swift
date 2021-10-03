//
//  SelectableListProtocol.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import Foundation

/// For selectable TableViews.
protocol SelectableListProtocol: ListProtocol {
    func itemSelected(at: IndexPath)
}
