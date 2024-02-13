//
//  .swift
//
//
//  Created by Davron Abdukhakimov on 11/01/24.
//

import SwiftUI
import AVFoundation

enum Circles{
    case focusCircle
    case breakCircle
}
struct TimerView: View {
    
    @State var focusTimeLeft = 0.0
    @State var breakTimeLeft = 0.0
    @State var timePassed = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var isStart = false
    @State var isPause = false
    @State var isBreak = false
    @State var isShowingTimerForm = false
    
    @State var currentCircle:Circles = .focusCircle
    @State var selectedSong = "Cinelax"
    @State var audioPlayer: AVAudioPlayer!
    @State var isPlayingMusic = false
    let timerObject:TimerDataModel
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                VStack{
                    TabView(selection: $currentCircle){
                        CircularProgressView(
                            title: "Focus",
                            seconds: focusTimeLeft,
                            progress: focusTimeLeft / convertToSeconds(date: timerObject.focusTime)
                        )
                        .tag(Circles.focusCircle)
                        .padding(.bottom)
                        CircularProgressView(
                            title: "Break",
                            seconds: breakTimeLeft,
                            progress: breakTimeLeft / Double(timerObject.breakTime * 60)
                        )
                        .tag(Circles.breakCircle)
                        .padding(.bottom)
                    }
                    .frame(width: 300,height: 350)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .animation(.easeOut(duration: 1), value: currentCircle)
                    if !isStart{
                        Button{
                            isStart = true
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 310,height: 50)
                                Label("Start", systemImage: "play.fill")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.top,20)
                    }
                    else{
                        VStack{
                            HStack(spacing:10){
                                Button{
                                    isPause.toggle()
                                }label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(width: 150,height: 50)
                                        Label(isPause ? "Resume" : "Pause", systemImage: isPause ? "play.circle.fill" : "pause.circle.fill")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                    }
                                }
                                Button{
                                    if isBreak{
                                        breakTimeLeft = timerObject.breakTime * 60
                                    }
                                    else {
                                        focusTimeLeft = convertToSeconds(date: timerObject.focusTime)
                                        timePassed = 0
                                    }
                                    
                                }label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.gray)
                                            .frame(width: 150,height: 50)
                                        Text("Reset")
                                            .font(.title2)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                            Button{
                                isBreak.toggle()
                            }label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: 310,height: 50)
                                    Text(isBreak ? "Focus" : "Take Break")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                }
                            }
                            .padding(.bottom)
                            
                            VStack(alignment:.leading) {
                                    Toggle("Play Music", isOn: $isPlayingMusic)
                                    HStack{
                                        Text("Select The Song:")
                                            .opacity(isPlayingMusic ? 1.0 : 0.3)
                                        Spacer()
                                        Picker("", selection: $selectedSong) {
                                            Text("Cinelax")
                                                .tag("Cinelax")
                                            Text("Deeper Meaning")
                                                .tag("DeeperMeaning")
                                            Text("Noisescape")
                                                .tag("Noisescape")
                                        }
                                    }
                                    .padding(.bottom)
                                    .disabled(!isPlayingMusic)
                                    Text("The songs are composed by Liborio Conti")
                                        .foregroundStyle(.secondary)
                                        .font(.title3)
                                }
                                .padding(.horizontal)
                            
                            
                            
                        }
                        .padding(.top,20)
                    }
                }
                .padding()
            }
            
            .navigationTitle(timerObject.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        isShowingTimerForm = true
                    }label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
                
            }
        }
        
        
        .onReceive(timer) { _ in
            if !isBreak && focusTimeLeft > 0 && isStart && !isPause{
                focusTimeLeft -= 1
                timePassed += 1
            }
            if isBreak && breakTimeLeft >= 0 && isStart && !isPause{
                breakTimeLeft -= 1
            }
            
        }
        .onChange(of:selectedSong){
            audioPlayer.stop()
            audioPlayer = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: selectedSong, withExtension: "mp3")!)
            audioPlayer.play()
        }
        .onChange(of: isPlayingMusic){
            if isPlayingMusic{
                audioPlayer = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: selectedSong, withExtension: "mp3")!)
                audioPlayer.play()
            }
            else{
                audioPlayer.stop()
            }
        }
        .onChange(of:isBreak){
            if isBreak{
                breakTimeLeft = timerObject.breakTime * 60
                timePassed = 0
                withAnimation {
                    currentCircle = .breakCircle
                }
            }
            else{
                withAnimation {
                    currentCircle = .focusCircle
                }
            }
        }
        .onChange(of: breakTimeLeft){
            if breakTimeLeft < 0 {
                isBreak = false
                focusTimeLeft += 1
            }
        }
        .onChange(of:timePassed){
            
            if timePassed > timerObject.breakInterval * 60 && focusTimeLeft != 0 {
                isBreak = true
            }
        }
        .task(id: timerObject.focusTime){
            focusTimeLeft = convertToSeconds(date: timerObject.focusTime)
            timePassed = 0
            
        }
        .task(id: timerObject.breakTime){
            breakTimeLeft = timerObject.breakTime * 60
            timePassed = 0
        }
        .sheet(isPresented: $isShowingTimerForm) {
            TimerFormView(
                timer: timerObject,
                focusTime: initialTime.addingTimeInterval(3600),
                isShowingForm: $isShowingTimerForm,
                isCreating: false
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    TimerView(timerObject: TimerDataModel(
        title: "Assignment Session",
        focusTime: Date(),
        breakTime: 1,
        breakInterval: 1
    )
    )
}

struct CircularProgressView: View {
    
    let title:String
    var seconds: Double
    var progress: Double
    
    var body: some View {
        VStack{
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom,50)
            ZStack{
                Circle()
                    .stroke(
                        Color.accentColor.opacity(0.3),
                        lineWidth: 10
                    )
                    .frame(width: 250)
                Circle()
                    .trim(from: 0,to: progress)
                    .stroke(
                        Color.accentColor,
                        style: StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round
                        )
                    )
                    .frame(width: 250)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear, value: progress)
                Text(getTimerString(seconds: seconds))
                    .italic()
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundStyle(Color.accentColor)
            }
            Spacer()
        }
        
        
        
        
    }
}

