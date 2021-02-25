Class {
	#name : #TriasEventDeparture,
	#superclass : #TriasObject,
	#instVars : [
		'stopPointRef',
		'stopPointName',
		'serviceDeparture'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'instance creation' }
TriasEventDeparture class >> fromXML: anXMLElement [

	^ self new
		initializeFromXML: anXMLElement;
		yourself
]

{ #category : #'instance creation' }
TriasEventDeparture class >> xmlElementName [

	^ 'CallAtStop'
]

{ #category : #services }
TriasEventDeparture >> initializeFromXML: anXMLElement [

	self stopPointRef: (self extractValueFrom: anXMLElement element: 'StopPointRef').
	self stopPointName: (self extractValueFrom: (anXMLElement findElementNamed: 'StopPointName') element: 'Text').
	serviceDeparture :=  (anXMLElement findElementNamed: 'ServiceDeparture').
	serviceDeparture ifNotNil: [  
		self serviceDeparture: (self extractValueFrom: serviceDeparture element: 'TimetabledTime' convert: [:string | DateAndTime fromString: string ]).
		].
	
]

{ #category : #accessing }
TriasEventDeparture >> serviceDeparture [
	^ serviceDeparture
]

{ #category : #accessing }
TriasEventDeparture >> serviceDeparture: anObject [
	serviceDeparture := anObject
]

{ #category : #accessing }
TriasEventDeparture >> stopPointName [
	^ stopPointName
]

{ #category : #accessing }
TriasEventDeparture >> stopPointName: anObject [
	stopPointName := anObject
]

{ #category : #accessing }
TriasEventDeparture >> stopPointRef [
	^ stopPointRef
]

{ #category : #accessing }
TriasEventDeparture >> stopPointRef: anObject [
	stopPointRef := anObject
]
