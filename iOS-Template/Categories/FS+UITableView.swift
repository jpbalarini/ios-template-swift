//
//  FSExtensions+UITableView.swift
//  SwiftHelpers
//

import UIKit

extension UITableView {
    func deselectSelectedRow (animated:Bool) {
        if ((self.indexPathForSelectedRow) != nil) {
            self.deselectRowAtIndexPath(self.indexPathForSelectedRow!, animated: animated)
        }
    }
}
