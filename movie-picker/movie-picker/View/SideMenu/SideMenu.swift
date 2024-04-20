import SwiftUI

struct SideMenu: View {
    @State private var selectedMood: String = "Need to see Action"
    
    let moodOptions = [
        "Need to see Action  🚀",
        "LOVE LOVE LOVE 777  🧡",
        "Wanna Cry  😢",
        "Something Real  💪",
        "Anything can't scare me  😬",
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("What's your mood?")
                    .font(.custom("SFProRounded-Bold", size: 23))
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            .padding(.top, 100)
            
            Divider()
            
            ForEach(moodOptions.indices, id: \.self) { index in
                let mood = moodOptions[index]
                ZStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Image(systemName: mood == selectedMood ? "popcorn.fill" : "popcorn")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.iconOrange)
                          
                        Text(mood)
                            .font(.custom("SFProRounded-Regular", size: 16))
                            .foregroundColor(mood == selectedMood ? .yellow : .white)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .cornerRadius(8)
                    }
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            self.selectedMood = mood
                        }
                    }
                    .scaleEffect(mood == selectedMood ? 1.1 : 1)
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 10))
                    .frame(width: .infinity, alignment: .leading)
                    .offset(x:mood == selectedMood ? 10 : 0)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.iconOrange, lineWidth: 2)
                        .frame(width: 270, height: 50)
                        .background(mood == selectedMood ? .imdbYellow.opacity(0.1) : Color.clear)
                        .opacity(mood == selectedMood ? 1 : 0)
                        .padding(.leading, 10)
                }
            }
            Spacer()
        }
        .frame(maxWidth: 288, maxHeight: .infinity)
        .background(.bgBlack)
        .cornerRadius(16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SideMenu()
}
