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
    private let haptics = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        VStack {
            Spacer()
            Text(project.name)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding([.bottom], 4)
            Text("\(project.count)")
                .font(Font.system(size: 128))
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .padding([.bottom], 32)
            Spacer()
            HStack {
                Button {
                    project.updateCount(by: -1)
                    haptics.impactOccurred(intensity: 1.0)
                } label: {
                    Text("-")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .disabled(project.count == 0)
                .simultaneousGesture(
                    LongPressGesture().onEnded { _ in
                        project.setCount(0)
                    }
                )
                .frame(width: 120, height: 100)
                .glassEffect(.regular.interactive())
                Spacer().frame(width: 64)
                Button {
                    project.updateCount(by: 1)
                    haptics.impactOccurred(intensity: 1.0)
                } label: {
                    Text("+")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 120, height: 100)
                .glassEffect(.regular.interactive())
            }
            .padding([.bottom], 32)
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
