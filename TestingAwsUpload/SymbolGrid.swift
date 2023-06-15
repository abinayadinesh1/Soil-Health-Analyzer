//
//  SymbolGrid.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/26/23.
//

import Foundation
import SwiftUI

struct SymbolGrid: View {
    @State private var isAddingSymbol = true
    @State private var isEditing = false
    private static let initialColumns = 3
    @State private var selectedSymbol: CoverImage?
    @State private var selectedImage: UIImage?
    @State private var numColumns = initialColumns
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    private var testImage: UIImage = UIImage(named: "green") ?? UIImage(named: "addNew")! //this works btw, idt u need extension if its in assets
    @State private var inputImage : UIImage = (UIImage(systemName: "xmark.square.fill") ?? UIImage(systemName: "addNew")!)
//    imageLiteralResourceName
//    = UIImage(systemName: "addNew")!
//    allow it to be blank from the start?
    //either use if let or

    @State private var symbols = [
        CoverImage(name: "hb1", cover: Image("hb1")), //sorry swift hates extensions
        CoverImage(name: "hb2", cover: Image("hb2")),
        CoverImage(name: "hb3", cover: Image("hb3")),
        CoverImage(name: "hb4", cover: Image("hb4")),
        CoverImage(name: "hb5", cover: Image("hb5")),
        CoverImage(name: "hb6", cover: Image("hb6")),
    ]
    
    var columnsText: String {
        numColumns > 1 ? "\(numColumns) Columns" : "1 Column"
    }
    var body: some View {
        VStack {
//            Image(uiImage: testImage)
            if isEditing {
                Stepper(columnsText, value: $numColumns, in: 1...6, step: 1) { _ in
                    withAnimation { gridColumns = Array(repeating: GridItem(.flexible()), count: numColumns) }
                }
                .padding()
            }
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(symbols) { symbol in
                        NavigationLink(destination: SymbolDetail(symbol: symbol)) {
                            ZStack(alignment: .topTrailing) {
                                symbol.cover
                                    .resizable()
                                    .scaledToFit()
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundColor(.accentColor)
                                    .ignoresSafeArea(.container, edges: .bottom)
                                    .cornerRadius(8)
                                
                                if isEditing {
                                    Button {
                                        guard let index = symbols.firstIndex(of: symbol) else { return }
                                        withAnimation {
                                            _ = symbols.remove(at: index)
                                        }
                                    } label: {
                                        Image(systemName: "xmark.square.fill")
                                            .font(.title)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, Color.red)
                                    }
                                    .offset(x: 7, y: -7)
                                }
                            }
                            .padding()
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .navigationTitle("My Symbols")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingSymbol, onDismiss: addSymbol) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $inputImage)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation { isEditing.toggle() }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddingSymbol = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(isEditing)
            }
        }
        
    }
    
    func addSymbol() {
        selectedSymbol = CoverImage(name: "my fav cutie", cover: Image(uiImage: selectedImage ?? UIImage(named: "green")!))
        guard let newCover = selectedSymbol else { return }
        withAnimation {
            symbols.insert(newCover, at: 0)
        }
    }
    }




struct GridView_Previews: PreviewProvider {
static var previews: some View {
    SymbolGrid()
}
}
