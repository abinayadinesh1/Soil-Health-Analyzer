//
//  ContentView.swift
//  UpdateGridViaView
//
//  Created by Abinaya on 5/23/23.
//

import SwiftUI


struct ContentView: View {
    @State private var views: [CreatedView] = []
    @State private var selectedView: CreatedView?
    
    var body: some View {
        NavigationView {
            VStack {
                if views.isEmpty {
                    Text("No views created")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                            ForEach(views.indices, id: \.self) { index in
                                NavigationLink(
                                    destination: EditView(view: $views[index])
                                        .navigationTitle(views[index].title),
                                    tag: views[index],
                                    selection: $selectedView
                                ) {
                                    Button(action: {
                                        selectedView = views[index]
                                    }) {
                                        Text(views[index].title)
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                    }
                }
                Button(action: {
                    createView {
                        Text("This is a custom view")
                    }
                }) {
                    Text("Create View")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

            }
            .padding()
            .navigationTitle("Created Views")
        }
    }
    
    func createView<Content: View>(content: @escaping () -> Content) {
        let text = Binding<String>(
            get: { "" }, // Default value
            set: { _ in } // Empty setter
        )
        let newView = CreatedView(title: "View \(views.count + 1)", text: text)
        views.append(newView)
    }

}

struct CreatedView: Identifiable, Hashable {
    let id = UUID()
    let title: String
    @Binding var text: String

    init(title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CreatedView, rhs: CreatedView) -> Bool {
        lhs.id == rhs.id
    }
}

struct EditView: View {
    @Binding var view: CreatedView
    
    var body: some View {
        VStack {
            Text(view.title)
                .font(.title)
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
            
            TextField("Enter text", text: view.$text)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
        }
    }
}


struct AnyViewContainer {
    @Binding var text: String
}

extension AnyView: View {
    public var body: some View {
        self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
