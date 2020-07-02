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


	self resultId: (anXMLElement findElementNamed: 'ResultId') contentString.
	self distance: (anXMLElement findElementNamed: 'Distance') contentString.
	self interchanges: ((anXMLElement findElementNamed: 'Interchanges') ) contentString asNumber.
	self projection: ((anXMLElement findElementNamed: 'Projection') elements collect: [ :each |
		(each findElementNamed: 'Longitude') contentString asNumber @ (each findElementNamed: 'Latitude') contentString asNumber
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
