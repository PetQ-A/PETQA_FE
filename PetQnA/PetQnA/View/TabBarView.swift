//
//  TabBarView.swift
//  PetQnA
//
//  Created by 김동섭 on 7/19/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var appState: AppState

    
    // TabBar 커스텀 = 배경색 설정 및 독립
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
                    .environmentObject(appState)
            }
            .tabItem {
                if selectedTab == 0 {
                    Image("tabbar_home_in_ic")
                } else {
                    Image("tabbar_home_ic")
                }
                Text("홈")
            }
            .tag(0)
            
            NavigationStack {
                //DiaryView()
            }
            .tabItem {
                if selectedTab == 1 {
                    Image("tabbar_diary_in_ic")
                } else {
                    Image("tabbar_diary_ic")
                }
                Text("기록")
            }
            .tag(1)
            
            NavigationStack {
                //CommunityView()
            }
            .tabItem {
                if selectedTab == 2 {
                    Image("tabbar_community_in_ic")
                } else {
                    Image("tabbar_community_ic")
                }
                Text("커뮤니티")
            }
            .tag(2)
            
            NavigationStack {
                //MyPageView()
            }
            .tabItem {
                if selectedTab == 3 {
                    Image("tabbar_mypage_in_ic")
                } else {
                    Image("tabbar_mypage_ic")
                }
                Text("마이페이지")
            }
            .tag(3)
        }
        .navigationBarBackButtonHidden(true) // 뒤로 가기 버튼 숨기기 + 차후 수정할 가능성 O
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(AppState())
    }
}


