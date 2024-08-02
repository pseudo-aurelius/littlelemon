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
    
    var body: some View {
        VStack() {
            Text("Little Lemon")
            Text("Chicago")
            Text("Try our modern takes on some classic Mediterranean staples")
            
            FetchedObjects() { (dishes: [Dish]) in
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
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
