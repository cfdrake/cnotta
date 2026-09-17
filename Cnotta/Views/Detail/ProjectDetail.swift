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
            Spacer()
            Text(project.name)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding([.bottom], 16)
            Text("\(project.count)")
                .font(.title)
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .padding([.bottom], 32)
            Spacer()
            HStack {
                Button {
                    project.updateCount(by: -1)
                } label: {
                    Text("-")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .frame(width: 120, height: 100)
                .background(.white.opacity(0.2))
                .cornerRadius(32)
                Button {
                    project.updateCount(by: 1)
                } label: {
                    Text("+")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .frame(width: 120, height: 100)
                .background(.white.opacity(0.2))
                .cornerRadius(32)
            }
            .padding([.bottom], 48)
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
