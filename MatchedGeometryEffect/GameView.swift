//
//  GameView.swift
//  MatchedGeometryEffect
//
//  Created by ice on 2024/8/19.
//

import SwiftUI

struct GameView: View {
    @Binding var isPresent: Bool
    let game: Game
    var animationNs: Namespace.ID
    
    @State private var dragOffset = CGSize.zero
    @State private var scaleAmount: CGFloat = 1.0
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            ScrollView{
                VStack{
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
                    .matchedGeometryEffect(id: game.title, in: animationNs)
                    Text(game.summary)
                        .padding()
                }
            }
            .background(.lightBg)
            
            HStack{
                Spacer()
                Button(action: {
                    withAnimation{
                        self.isPresent = false
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.black.opacity(0.6))
                        .clipShape(.circle)
                        .opacity((scaleAmount - 1) / 0.15 + 1)
                })
                
            }
            .padding()
            .padding(4)
        }
        .clipShape(.rect(cornerRadius: dragOffset.width > 5 ? (55 * scaleAmount) : 0))
        .scaleEffect(scaleAmount)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    let edgeX = UIScreen.main.bounds.width * 0.1
                    if(dragOffset.width == 0 && gesture.location.x > edgeX){
                        return
                    }
                    dragOffset = gesture.translation
                    let dragPercentage = min(max(dragOffset.width / UIScreen.main.bounds.width, 0), 1)
                    scaleAmount = 1.0 - dragPercentage * 0.5
                    if dragOffset.width > UIScreen.main.bounds.width * 0.3 {
                        withAnimation{
                            isPresent = false
                        }
                    }
                }
                .onEnded { _ in
                    if(isPresent){
                        withAnimation(.spring()) {
                            dragOffset = .zero
                            scaleAmount = 1.0
                        }
                    }
                }
        )
    }
}

#Preview {
    @Namespace var animationNs
    let game = Game(cover: "wukong", title: "黑神话：悟空", summary: "《黑神话：悟空》是一款以中国神话为背景的动作角色扮演游戏。你将扮演一位“天命人”，为了探寻昔日传说的真相，踏上一条充满危险与惊奇的西游之路。")
    return GameView(isPresent: .constant(true), game: game, animationNs: animationNs)
}
