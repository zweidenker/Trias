Class {
	#name : #TriasEventResult,
	#superclass : #TriasObject,
	#instVars : [
		'resultId',
		'stopPointRef',
		'stopPointName',
		'serviceDeparture',
		'operatingDayRef',
		'lineRef',
		'transportationMode',
		'transportationSubMode'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'instance creation' }
TriasEventResult class >> fromXML: anXMLElement [

	^ self new
		initializeFromXML: anXMLElement;
		yourself
]

{ #category : #'as yet unclassified' }
TriasEventResult class >> xmlElementName [
	^ 'EventResult'
]

{ #category : #initialization }
TriasEventResult >> initializeFromXML: anXMLElement [


	self resultId: (anXMLElement findElementNamed: 'ResultId') contentString.
	self stopPointRef: (anXMLElement findElementNamed: 'StopPointRef') contentString.
	self stopPointName: ((anXMLElement findElementNamed: 'StopPointName') elementAt: 'Text') contentString.
	self serviceDeparture: (DateAndTime fromString: ((anXMLElement findElementNamed: 'ServiceDeparture') elementAt: 'TimetabledTime') contentString).
	self operatingDayRef:  (Date fromString: (anXMLElement findElementNamed: 'OperatingDayRef') contentString).
	self lineRef:  (anXMLElement findElementNamed: 'LineRef') contentString.
	self transportationMode:  (anXMLElement findElementNamed: 'PtMode') contentString.
	(anXMLElement findElementNamed: 'RailSubmode') ifNotNil: [ :anElement | self transportationSubMode: anElement contentString ].
	(anXMLElement findElementNamed: 'BusSubmode') ifNotNil: [ :anElement | self transportationSubMode: anElement contentString ].
	(anXMLElement findElementNamed: 'TramSubmode') ifNotNil: [ :anElement | self transportationSubMode: anElement contentString ].
	
	
]

{ #category : #accessing }
TriasEventResult >> lineRef [

	^ lineRef
]

{ #category : #accessing }
TriasEventResult >> lineRef: aString [

	lineRef := aString
]

{ #category : #accessing }
TriasEventResult >> operatingDayRef [

	^ operatingDayRef
]

{ #category : #accessing }
TriasEventResult >> operatingDayRef: aDate [

	operatingDayRef := aDate
]

{ #category : #accessing }
TriasEventResult >> resultId [

	^ resultId
]

{ #category : #accessing }
TriasEventResult >> resultId: aString [

	resultId := aString
]

{ #category : #accessing }
TriasEventResult >> serviceDeparture [

	^ serviceDeparture
]

{ #category : #accessing }
TriasEventResult >> serviceDeparture: aDateAndTime [

	serviceDeparture := aDateAndTime
]

{ #category : #accessing }
TriasEventResult >> stopPointName [

	^ stopPointName 
]

{ #category : #accessing }
TriasEventResult >> stopPointName: aString [

	stopPointName := aString
]

{ #category : #accessing }
TriasEventResult >> stopPointRef [

	^ stopPointRef
]

{ #category : #accessing }
TriasEventResult >> stopPointRef: aString [

	stopPointRef := aString
]

{ #category : #accessing }
TriasEventResult >> transportationMode [

	^ transportationMode
]

{ #category : #accessing }
TriasEventResult >> transportationMode: aString [

	transportationMode := aString
]

{ #category : #accessing }
TriasEventResult >> transportationSubMode [

	^ transportationSubMode
]

{ #category : #accessing }
TriasEventResult >> transportationSubMode: aString [

	transportationSubMode := aString
]
