//
//  ProjectListRow.swift
//  Cnotta
//
//  Created by Colin Drake on 9/17/26.
//

import SwiftUI

struct ProjectListRow: View {
    
    let project: Project
    
    var body: some View {
        HStack {
            VStack {
                Text(project.name)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: Alignment(horizontal: .leading, vertical: .center))
                Text("\(project.count)")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: Alignment(horizontal: .leading, vertical: .center))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color.fromHexCode(project.color))
        .cornerRadius(32)
    }
}

#Preview {
    let project = Project(
        id: UUID(),
        name: "Test",
        created: Date(),
        modified: Date(),
        count: 10,
        color: 0xcc0000
    )
    
    ProjectListRow(project: project)
}
