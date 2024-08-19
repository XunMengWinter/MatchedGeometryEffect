//
//  ContentView.swift
//  MatchedGeometryEffect
//
//  Created by ice on 2024/8/19.
//

import SwiftUI

struct ContentView: View {
    
    let gameList: [Game] = [
        Game(cover: "wukong", title: "黑神话：悟空", summary: "《黑神话：悟空》是一款以中国神话为背景的动作角色扮演游戏。你将扮演一位“天命人”，为了探寻昔日传说的真相，踏上一条充满危险与惊奇的西游之路。"),
        Game(cover: "forza", title: "Forza Horizon 5", summary: "地平线5引入一个新的天气系统。由于墨西哥幅员辽阔，因此游戏中整个地图会同时出现多种气候，四个季节仍然存在，季节也会影响地图周边的11个独特的生物群落。"),
        Game(cover: "horizon", title: "Horizon Zero Dawn", summary: "传闻巴努克族领地挥刀断崖附近的雷鼓山正猛窜黑烟，且有凶暴的机器生物出现。埃洛伊因而前往调查..."),
        Game(cover: "machinarium", title: "Machinarium", summary: "机械迷城(Machinarium)中每个角色都是机器人,包括我们的小英雄,他将为了对付坏人并解救自己的女朋友展开了一系列的解谜，没有多余的对白，游戏情节和线索皆靠细腻的动画来表现。"),
    ]
    
    @State var selectedGame: Game?
    @Namespace var animationNs

    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    ForEach(gameList, id: \.title){game in
                        ZStack(alignment: .bottomLeading){
                            Rectangle()
                                .foregroundStyle(.clear)
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(content: {
                                    Image(game.cover)
                                        .resizable()
                                        .scaledToFill()
                                })
                            
                            Text(game.title)
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding()
                        }
                        .clipShape(.rect(cornerRadius: 16))
                        .onTapGesture {
                            withAnimation{
                                selectedGame = game
                            }
                        }
                        .matchedGeometryEffect(id: game.title, in: animationNs)
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    
                    Link("Star on GitHub", destination: URL(string: "https://github.com/XunMengWinter/MatchedGeometryEffect")!)
                        .padding()
                }
            }
            .navigationTitle("Game")
            .game(bindable: $selectedGame, destination:{ game in
                GameView(isPresent: $selectedGame.toBoolBinding, game: game, animationNs: animationNs)
            })
            .toolbar(selectedGame == nil ? .visible : .hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
