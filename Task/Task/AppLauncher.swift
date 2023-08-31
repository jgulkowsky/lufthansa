//
//  AppLauncher.swift
//  Task
//
//  Created by Jan Gulkowski on 31/08/2023.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            TaskApp.main()
        } else {
            TestApp.main()
        }
    }
}
