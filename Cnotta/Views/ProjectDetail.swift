//
//  ProjectDetail.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI
import SwiftData

struct ProjectDetail: View {

    @EnvironmentObject var navigation: AppNavigator
    @Environment(\.dismiss) var dismiss
    let project: Project
    let idleTimerController: IdleTimerProvider?
    let haptics: HapticsProvider?
    @State var isPresentingEditForm: Bool = false
    
    init(project: Project, idleTimerController: IdleTimerProvider? = nil, haptics: HapticsProvider? = nil) {
        self.project = project
        self.idleTimerController = idleTimerController
        self.haptics = haptics
    }
    
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
                    haptics?.generateHapticEvent()
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
                        haptics?.generateHapticEvent()
                    }
                )
                .frame(width: 120, height: 100)
                .glassEffect(.regular.interactive())
                Spacer().frame(width: 64)
                Button {
                    project.updateCount(by: 1)
                    haptics?.generateHapticEvent()
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Project settings", systemImage: "gear") {
                    isPresentingEditForm = true
                }
                .foregroundStyle(.white)
            }
        }
        .onAppear {
            idleTimerController?.isIdleTimerDisabled = true
        }
        .onDisappear {
            idleTimerController?.isIdleTimerDisabled = false
        }
        .sheet(isPresented: $isPresentingEditForm) {
            EditProjectForm(project: project, onDelete: {
                navigation.navigateToRoot()
            })
            .environmentObject(navigation)
        }
    }
}

#Preview {
    let project = Project(name: "Project 1", color: 0xff0000)

    NavigationStack {
        ProjectDetail(project: project)
    }
}
