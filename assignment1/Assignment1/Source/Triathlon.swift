//
//  Triathlon.swift
//  Assignment1
//

enum Triathlon {
    case sprint
    case olympic
    case halfIronman
    case ironman
    func distance(for sport: Sport) -> Int{
        let length: Int
        //tuples to store length values
        switch (self, sport){
            case(.sprint, .swimming):
            length = 750
            case(.sprint, .cycling):
            length = 20000
            case(.sprint, .running):
            length = 5000
            case(.olympic, .swimming):
            length = 1500
            case(.olympic, .cycling):
            length = 40000
            case(.olympic, .running):
            length = 10000
            case(.halfIronman, .swimming):
            length = 1930
            case(.halfIronman, .cycling):
            length = 90000
            case(.halfIronman, .running):
            length = 21090
            case(.ironman, .swimming):
            length = 3860
            case(.ironman, .cycling):
            length = 180000
            case(.ironman, .running):
            length = 42200
        }
        return length
    }
    //store sports types in order
    static let sports: Array<Sport> = [Sport.swimming, Sport.cycling, Sport.running]
}
