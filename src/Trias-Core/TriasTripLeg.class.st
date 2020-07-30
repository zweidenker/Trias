Class {
	#name : #TriasTripLeg,
	#superclass : #TriasObject,
	#instVars : [
		'projection',
		'transportationMode',
		'lineName',
		'lineRef'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'instance creation' }
TriasTripLeg class >> fromXML: anXMLElement [

	^ self new
		initializeFromXML: anXMLElement;
		yourself
]

{ #category : #'as yet unclassified' }
TriasTripLeg class >> xmlElementName [
	^ 'TripLeg'
]

{ #category : #initialization }
TriasTripLeg >> initializeFromXML: anXMLElement [

	(anXMLElement findElementNamed: 'Projection')ifNotNil: [:projectionElement |
		self
		projection: (projectionElement elements
				collect: [ :each | 
					(self extractValueFrom: each element: 'Longitude' convert: #asNumber)
						@ (self extractValueFrom: each element: 'Latitude' convert: #asNumber) ]).
		  ].
	
					
	self
		transportationMode: (self
				extractOptionalValueFrom: anXMLElement
				element: 'PtMode').
				
	self lineRef: (self
				extractOptionalValueFrom: anXMLElement
				element: 'LineRef').

	(anXMLElement findElementNamed: 'PublishedLineName') ifNotNil: [:aXMLElement |
		self lineName: (self
				extractOptionalValueFrom: aXMLElement
				element: 'Text').
		].
	
]

{ #category : #accessing }
TriasTripLeg >> lineName [

	^ lineName 
]

{ #category : #accessing }
TriasTripLeg >> lineName: aString [

	lineName := aString

	
]

{ #category : #accessing }
TriasTripLeg >> lineRef [

	^ lineRef
]

{ #category : #accessing }
TriasTripLeg >> lineRef: aString [

	lineRef := aString
]

{ #category : #accessing }
TriasTripLeg >> projection [

	^ projection

	
]

{ #category : #accessing }
TriasTripLeg >> projection: aCollectionOfPoints [

	projection :=  aCollectionOfPoints
	
]

{ #category : #accessing }
TriasTripLeg >> transportationMode [

	^ transportationMode

	
]

{ #category : #accessing }
TriasTripLeg >> transportationMode: aString [

	transportationMode := aString

	
]
