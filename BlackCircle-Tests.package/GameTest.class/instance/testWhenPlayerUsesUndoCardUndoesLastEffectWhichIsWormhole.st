test-InstantCard
testWhenPlayerUsesUndoCardUndoesLastEffectWhichIsWormhole
	| board playerOne game playerTwo overloadCard undoCard overloadCardOne undoCardOne deck |
	playerOne := self playerGuada.
	playerTwo := self playerFacu.
	board := Board
		with: 20
		boxesGeneratingEffectsFrom:
			(FixedEffectSequence
				generating:
					{NoEffect new.
					WormholeEffect new}).
	overloadCard := self overloadCard.
	undoCard := self undoCard.
	overloadCardOne := self overloadCard.
	undoCardOne := self undoCard.
	deck := Deck
		generatingCardsFrom:
			(FixedCardSequence
				generating:
					{overloadCard.
					undoCard.
					overloadCardOne.
					undoCardOne}).
	game := Game
		withBoard: board
		requiredLapsToWin: 1
		involving:
			{playerOne.
			playerTwo}
		generatingCardsFrom: deck
		withDices: {(Dice with: 6 facesGeneratingNumbersFrom: (FixedNumberSequence generating: #(3 1 2 1)))}.
	game playTurn: playerOne.
	self assert: (board positionOf: playerOne) currentBox equals: 3.
	self assert: (board positionOf: playerOne) currentLap equals: 0.
	game playTurn: playerTwo.
	self assert: (board positionOf: playerTwo) currentBox equals: 1.
	self assert: (board positionOf: playerTwo) currentLap equals: 0.
	game playTurn: playerOne.
	self assert: (board positionOf: playerOne) currentBox equals: 5.
	self assert: (board positionOf: playerOne) currentLap equals: 0.
	game playTurn: playerTwo.
	self assert: (board positionOf: playerTwo) currentBox equals: -2.
	self assert: (board positionOf: playerTwo) currentLap equals: 0.
	game apply: undoCard playedBy: playerOne.
	self assert: (board positionOf: playerTwo) currentBox equals: 2.
	self assert: (board positionOf: playerTwo) currentLap equals: 0