//
//  Menu.swift
//  Little Lemon
//
//  Created by Drew Curtin on 8/2/24.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText: String = ""
    
    var body: some View {
        VStack() {
            Header()
            
            Hero()
                .padding(.bottom, -10)
            
            HStack() {
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                TextField("", text: $searchText, prompt: Text("Explore Our Menu").foregroundColor(.black))
                    

            }.padding(5).border(Color(hex: "FFFFF"), width: 2 ).cornerRadius(4).padding(15).background(Color(hex: "#495E57"))
            
            VStack() {
                Text("ORDER FOR DELIVERY")
                    .font(.custom("AlNile-Bold", size: 16))
                    .foregroundColor(Color(hex: "#FFFFF"))
                
                HStack() {
                    Button("Starters") {
                        
                    }.padding(10).foregroundColor(Color(hex: "#71807B")).font(.custom("AlNile-Bold", size: 15)).background(Color(hex: "#AFAFAF")).cornerRadius(12)
                    
                    Button("Mains") {
                        
                    }.padding(10).foregroundColor(Color(hex: "#71807B")).font(.custom("AlNile-Bold", size: 15)).background(Color(hex: "#AFAFAF")).cornerRadius(12)
                    
                    Button("Desserts") {
                        
                    }.padding(10).foregroundColor(Color(hex: "#71807B")).font(.custom("AlNile-Bold", size: 15)).background(Color(hex: "#AFAFAF")).cornerRadius(12)
                    
                    Button("Drinks") {
                        
                    }.padding(10).foregroundColor(Color(hex: "#71807B")).font(.custom("AlNile-Bold", size: 15)).background(Color(hex: "#AFAFAF")).cornerRadius(12)
                }.padding(.top, -10)
            }.padding(.bottom, 10)
             
            Divider()
                .padding(.top, 15)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List() {
                    ForEach(dishes, content: {dish in
                        HStack() {
                            VStack(alignment: .leading) {
                                Text(dish.title!)
                                    .font(.custom("AlNile-Bold", size: 16))
                                    .foregroundColor(Color(hex: "#FFFFF"))
                                
                                Text(dish.desc!)
                                    .lineLimit(2)
                                    .font(.custom("AlNile", size: 14))
                                    .foregroundColor(Color(hex: "#FFFFF"))
                                    .padding(.top, 1)
                                    .padding(.bottom, 1)
                                
                                Text("$" + dish.price!)
                                    .font(.custom("AlNile", size: 20))
                                    .foregroundColor(Color(hex: "#333333"))
                            }
                            
                            Spacer()
 
                           AsyncImage(url: URL(string: dish.image!)) { image in
                               image.resizable()
                           } placeholder: {
                               ProgressView()
                           }
                           .frame(width: 100, height: 100)
                        }
                    })
                }.scrollContentBackground(.hidden)
            }
        }.onAppear() {
            getMenuData()
        }
    }
    
    // Methods
    func getMenuData() {
        let menuAddress: String = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuURL = URL(string: menuAddress)
        let menuRequest = URLRequest(url: menuURL!)     // Force unwrap, URL is const
        
        let menuTask = URLSession.shared.dataTask(with: menuRequest) { data, response, error in
            if let data = data {
                // Decode the data to a menu
                let menuDecoder = JSONDecoder();
                let menuList = try! menuDecoder.decode(MenuList.self, from: data)
                
                menuList.menu.forEach() { menuItem in
                    let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "title == %@", menuItem.title)
                                        
                    if let result = try? viewContext.fetch(fetchRequest), result.isEmpty {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.price = menuItem.price
                        dish.image = menuItem.image
                        dish.desc = menuItem.description
                        
                        try? viewContext.save();
                    }
                }
            }
        }
        
        menuTask.resume();
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if (searchText.isEmpty) {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
