//
//  main.swift
//  Assignment1
//

let triEvent = TriathlonEvent(triathlon: .ironman)
let swimmer1 = Swimmer(name: "Cassi")
let swimmer2 = Swimmer(name: "Jason")
let swimmer3 = Swimmer(name: "Kathy")
let cyclist1 = Cyclist(name: "Asia")
let cyclist2 = Cyclist(name: "David")
let runner1 = Runner(name: "Sigh")
let runner2 = Runner(name: "Becky")
let athlete1 = Athlete(name: "Charles")
let athlete2 = Athlete(name: "Chuck")
triEvent.register(swimmer1)
triEvent.register(swimmer2)
triEvent.register(swimmer3)
triEvent.register(cyclist1)
triEvent.register(cyclist2)
triEvent.register(runner1)
triEvent.register(runner2)
triEvent.register(athlete1)
triEvent.register(athlete2)


triEvent.simulate()
if triEvent.winner == nil{
    print("No one finished the race!")
}else{
    let endTime = triEvent.raceTime(for: triEvent.winner!)!
    print(triEvent.winner!.name + " wins first place with a total time of " + String(endTime) + " minutes!")
}
