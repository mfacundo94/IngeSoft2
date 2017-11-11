test-Card
testWhenPlayerUsesAnulationCardItAnulatesLastCard
	| playerGuada board game playerFacu overloadCard anulationCard deck |
	playerGuada := self playerGuada.
	playerFacu := self playerFacu.
	board := Board with: 20 boxesGeneratingEffectsFrom: (FixedEffectSequence generating: {NoEffect new}).
	overloadCard := OverloadCard new.
	anulationCard := AnulationCard new.
	deck := Deck generatingCardsFrom: 	(FixedCardSequence
				generating:
					{overloadCard.
					anulationCard}).
	game := Game
		withBoard: board
		requiredLapsToWin: 3
		involving:
			{playerGuada.
			playerFacu}
		generatingCardsFrom:deck
		
		withDices: {(Dice with: 6 facesGeneratingNumbersFrom: (FixedNumberSequence generating: #(4 1)))}.
	game player: playerGuada appliesCard: overloadCard to: playerGuada.
	game playTurn: playerGuada.
	self assert: (board positionOf: playerGuada) currentBox equals: 2.
	self assert: (board positionOf: playerGuada) currentLap equals: 0.
	game player: playerFacu appliesCard: anulationCard toPermanetCard: overloadCard.
	game playTurn: playerFacu.
	self assert: (board positionOf: playerFacu) currentBox equals: 1.
	self assert: (board positionOf: playerFacu) currentLap equals: 0.
	game player: playerGuada appliesCard: overloadCard to: playerFacu.
	game playTurn: playerGuada.
	self assert: (board positionOf: playerGuada) currentBox equals: 4.
	self assert: (board positionOf: playerGuada) currentLap equals: 0.
	game player: playerFacu appliesCard: overloadCard to: playerFacu.
	game playTurn: playerFacu.
	self assert: (board positionOf: playerFacu) currentBox equals: -2.
	self assert: (board positionOf: playerFacu) currentLap equals: 0