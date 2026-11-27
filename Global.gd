extends Node


var globalPlayerIndex :int = 9
var carryCharacter: int = 9
var globalRacewayIndex : int = 0
var globalRacewaySize : int
var minimum : float = 0.05
var startMenu : bool = false
var gameStart : bool = false
var loadedPlayers : Array = []
var characterNames: Array[String] = ["Grapeman","Orangeman","Bananaman","Strawberryman","Blueberryman","Pearman","Cherryman","Lemonman","Appleman","Peachman","Watermelonman","Starfruitman","Pineappleman","Mangoman","CoconutMan","Limeman"]
var playerName: String = "Peachman"
var winners: Array = []
var winnerTime : Array = []
var time : String = "0"
var difficulty : int = 6
var totalTime : int = 0
var countdown : bool = false
var isFinished : Array[bool] = [false, false, false, false]
var revolveCamera : bool = false
var winCondition : bool = true
var preview : bool =  false
var statScreen : bool = false
