//
//  ProjectDetail.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI

struct ProjectDetail: View {
    
    let project: Project
    let idleTimerController: IdleTimerController
    
    var body: some View {
        VStack {
            Text(project.name)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding([.bottom], 16)
            HStack {
                Button {
                    project.updateCount(by: -1)
                } label: {
                    Text("-")
                }
                .padding(64)
                .background(.white)
                .cornerRadius(32)
                Button {
                    project.updateCount(by: 1)
                } label: {
                    Text("+")
                }
                .padding(64)
                .background(.white)
                .cornerRadius(32)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.fromHexCode(project.color))
        .onAppear {
            idleTimerController.isIdleTimerDisabled = true
        }
        .onDisappear {
            idleTimerController.isIdleTimerDisabled = false
        }
    }
}

struct ProjectDetail_Previews: PreviewProvider {

    /// Mock idle timer (i.e. UIApplication) for Previews.
    final class MockUIApplication: IdleTimerController {
        var isIdleTimerDisabled: Bool = true
    }
    
    static var previews: some View {
        let project = Project(name: "Project 1", color: 0xff0000)

        ProjectDetail(project: project, idleTimerController: MockUIApplication())
    }
}
