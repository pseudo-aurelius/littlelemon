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
            Text("Little Lemon")
            Text("Chicago")
            Text("Try our modern takes on some classic Mediterranean staples")
            
            TextField("Search Our Menu", text: $searchText)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List() {
                    ForEach(dishes, content: {dish in
                        HStack() {
                            Text(dish.title!)
                            // TO DO - RESIZE THESE AsyncImage(url: URL(string: dish.image!))
                        }
                    })
                }
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
