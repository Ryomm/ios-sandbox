//
//  TaskView.swift
//  AppClipSampleApp
//

import Foundation
import SwiftUI

struct TaskView: View {
    @Binding var tasks: [Task]
    @State private var newTask = Task.emptyTask
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach($tasks) { $task in
                    HStack{
                        Button(action: {
                            withAnimation{
                                task.isDone.toggle()
                            }
                        }){
                            if task.isDone {
                                Image(systemName: "checkmark.circle.fill")
                            } else {
                                Image(systemName: "circle")
                            }
                        }
                        Text(task.title)
                    }
                    .opacity(task.isDone ? 0.3 : 1.0)
                }
                .onDelete{ task in
                    tasks.remove(atOffsets: task)
                }
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                    Button(action: {
                        withAnimation{
                            let task = Task(title: newTaskTitle)
                            tasks.append(task)
                            newTaskTitle = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .accessibilityLabel("Add Task")
                    .disabled(newTaskTitle.isEmpty)
                }
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(tasks: .constant(Task.sampleData))
    }
}

