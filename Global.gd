extends Node


var globalPlayerIndex :int = 9
var globalRacewayIndex : int = 0
var globalRacewaySize : int
var minimum : float = 0.05
var startMenu : bool = false
var gameStart : bool = false
var loadedPlayers : Array = []
var characterNames: Array[String] = ["Grapeman","Orangeman","Bananaman","Strawberryman","Blueberryman","Pearman","Cherryman","Lemonman","Appleman","Peachman","Watermelonman","Starfruitman","Pineappleman","Mangoman","Coconutman"]
var playerName: String = "Peachman"
var winners: Array = []
var time : String = "0"
var difficulty : int = 6
