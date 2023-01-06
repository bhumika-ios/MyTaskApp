//
//  HomeView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 06/01/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HeaderView()
        }
    }
    
    /// - Header View
    @ViewBuilder
    func HeaderView()->some View{
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 6){
                    Text("Today")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
