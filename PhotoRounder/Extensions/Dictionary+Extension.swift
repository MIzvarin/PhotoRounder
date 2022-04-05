//
//  Dictionary+Extension.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 02.03.2022.
//

import Foundation

extension Dictionary where Value: Equatable {
	func searchKey(for value: Value) -> Key? {
		first { $1 == value }?.key
	}
}
