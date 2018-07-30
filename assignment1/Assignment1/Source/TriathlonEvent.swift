//
//  TriathlonEvent.swift
//  Assignment1
//

class TriathlonEvent{
    let triathlon: Triathlon
    //initializer
    init(triathlon: Triathlon){
        self.triathlon = triathlon
    }
    //public reading, private writing
    private(set) var eventPerformed: Bool = false;
    var arrayParticipants: [Participant] = []
	var times: [String: Int] = [:]
//    var participantEventTime: [Int?] = []

    //register a Participant
    func register(_ participant: Participant){
        guard eventPerformed == false else{
            fatalError("unknown participant")
        }
        arrayParticipants.append(participant)
		times[participant.name] = 0
//        participantEventTime.append(0)
    }
    
    //return array of Participants
    var registeredParticipants: [Participant]{
        get{
            return arrayParticipants
        }
    }
    //return the race time of a participant
    func raceTime(for participant: Participant) -> Int?{
		return times[participant.name]

//		guard let position = arrayParticipants.index(where: {$0.name == participant.name}) else {
//			return nil
//		}
//
//		return participantEventTime[position]

//        let racetime: Int?
//        let position = arrayParticipants.index{$0.name == participant.name}
//        if position != nil{
//            racetime = participantEventTime[position!]
//            return racetime
//        }else{
//            return nil
//        }
    }
    
    //checking and printing the finishing time
    func simulate(_ sport: Sport, for participant: Participant, randomValue rvalue: Double = Double.random()){
		guard let currentTime = times[participant.name] else {
			return
		}
//		guard let spot = arrayParticipants.index(where: {$0.name == participant.name}), let currentTime = participantEventTime[spot] else {
//            return
//        }

		print("\(participant.name) is about to begin \(sport.description)")
//		print(participant.name + " is about to begin " + sport.description)

        if sport == participant.favoriteSport || rvalue >= 0.06{
            let completionTime = participant.completionTime(for:sport, in:triathlon)
			let newTime = currentTime + completionTime
			times[participant.name] = newTime
//			participantEventTime[spot] = newTime
			print("\(participant.name) finished the \(sport.description) event in \(completionTime) minutes; their total race time is now \(newTime) minutes.")
//            print(participant.name + " finished the " + sport.description + " event in " + String(completionTime) + " minutes; their total race time is now " + String(newTime) + " minutes.")
        }else if sport != participant.favoriteSport || rvalue < 0.06{
			times[participant.name] = nil
//            participantEventTime[spot] = nil
            print(participant.name + " could not finish the " + sport.description + " event and will not finish the race.")
        }
    }
    //simulate entire triathlon for a registered participant
    func simulate(){
        guard eventPerformed == false else{
            fatalError("varification fail")
        }
        for sport in Triathlon.sports{
            for player in arrayParticipants{
				simulate(sport, for: player)
            }
        }
        eventPerformed = true
    }
    
    //determine winner
    var winner: Participant?{
        get{
            guard eventPerformed == true else{
                fatalError("varification fail")
            }

			var winner: Participant? = nil
			for participant in arrayParticipants {
				guard let finishTime = times[participant.name] else {
					continue
				}

				guard let currentWinner = winner, let currentWinnerTime = times[currentWinner.name] else {
					winner = participant

					continue
				}

				guard currentWinnerTime > finishTime else {
					continue
				}

				winner = participant
			}

			return winner

//			var spot: Int?
//            var longest: Int? = nil
            
            //use guard else instead of if blocks
//            for finishTime in participantEventTime{
//                if finishTime != nil{
//                    if longest != nil{
//                        if let long: Int = longest, let finish: Int = finishTime{
//                            if long > finish{
//                                longest = finishTime
//                            }
//                        }
//                    }
//                }else{
//                    longest = finishTime
//                }
//            }
//            if longest == nil{
//                return nil
//            }else{
//                spot = participantEventTime.index{$0 == longest}
//                return arrayParticipants[spot!]
//            }
        }
    }
}
