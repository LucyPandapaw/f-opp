//
//  Sport.swift
//  Assignment1
//  will this be saved?

enum Sport {
    case swimming
    case cycling
    case running
    //get method for switching three cases
    public var description : String {
        get{
            let sportType: String
            switch self{
            case.cycling:
                sportType = "cycling"
            case.running:
                sportType = "running"
            case.swimming:
                sportType = "swimming"
            }
            return sportType
        }
    }
}


