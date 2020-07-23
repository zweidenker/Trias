Class {
	#name : #TriasTripResult,
	#superclass : #TriasObject,
	#instVars : [
		'resultId',
		'projection',
		'interchanges',
		'distance'
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
	self
		projection:
			((anXMLElement findElementNamed: 'Projection') elements
				collect: [ :each | 
					(self extractValueFrom: each element: 'Longitude' convert: #asNumber)
						@ (self extractValueFrom: each element: 'Latitude' convert: #asNumber) ])
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
TriasTripResult >> projection [

	^ projection

	
]

{ #category : #accessing }
TriasTripResult >> projection: aCollectionOfPoints [

	projection :=  aCollectionOfPoints
	
]

{ #category : #accessing }
TriasTripResult >> resultId [

	^ resultId
]

{ #category : #accessing }
TriasTripResult >> resultId: aString [

	resultId := aString
]
