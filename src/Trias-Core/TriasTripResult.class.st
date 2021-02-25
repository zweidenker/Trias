Class {
	#name : #TriasTripResult,
	#superclass : #TriasObject,
	#instVars : [
		'resultId',
		'interchanges',
		'distance',
		'legs'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'instance creation' }
TriasTripResult class >> fromXML: anXMLElement [

	^ self new
		initializeFromXML: anXMLElement;
		yourself
]

{ #category : #'as yet unclassified' }
TriasTripResult class >> xmlElementName [
	^ 'TripResult'
]

{ #category : #accessing }
TriasTripResult >> distance [

	^ distance 
	
]

{ #category : #accessing }
TriasTripResult >> distance: aNumber [

	distance := aNumber
	
]

{ #category : #initialization }
TriasTripResult >> initializeFromXML: anXMLElement [
	self
		resultId: (self extractValueFrom: anXMLElement element: 'ResultId').
	self
		distance: (self extractOptionalValueFrom: anXMLElement element: 'Distance').
	self
		interchanges:
			(self
				extractValueFrom: anXMLElement
				element: 'Interchanges'
				convert: #asNumber).
	self legs: ((anXMLElement allElementsNamed: 'TripLeg') asOrderedCollection collect: [:eachLegElement |
		TriasTripLeg fromXML: eachLegElement
		]).
	
]

{ #category : #accessing }
TriasTripResult >> interchanges [

	^ interchanges

	
]

{ #category : #accessing }
TriasTripResult >> interchanges: aNumber [

	interchanges := aNumber
	
]

{ #category : #accessing }
TriasTripResult >> isStraightLine [

	^ self legsWithProjection size = 1
	
]

{ #category : #accessing }
TriasTripResult >> legs [

	^ legs 
	
]

{ #category : #accessing }
TriasTripResult >> legs: aCollectionOfTripLeg [

	legs := aCollectionOfTripLeg
]

{ #category : #accessing }
TriasTripResult >> legsWithProjection [

	^ self legs select: [ :each | each projection notNil ]
	
]

{ #category : #accessing }
TriasTripResult >> resultId [

	^ resultId
]

{ #category : #accessing }
TriasTripResult >> resultId: aString [

	resultId := aString
]
