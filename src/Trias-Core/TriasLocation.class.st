Class {
	#name : #TriasLocation,
	#superclass : #TriasObject,
	#instVars : [
		'stopPoint',
		'name',
		'geoPosition',
		'locality',
		'poi'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'as yet unclassified' }
TriasLocation class >> xmlElementName [ 
	^ 'Location'
]

{ #category : #accessing }
TriasLocation >> geoPosition [
	^ geoPosition 
]

{ #category : #accessing }
TriasLocation >> geoPosition: aTriasGeoPosition [ 
	geoPosition := aTriasGeoPosition 
]

{ #category : #accessing }
TriasLocation >> locality [
	^ locality
]

{ #category : #accessing }
TriasLocation >> locality: aTriasLocality [ 
	locality := aTriasLocality 
]

{ #category : #accessing }
TriasLocation >> locationName: aTriasLocationName [ 
	name := aTriasLocationName 
]

{ #category : #'as yet unclassified' }
TriasLocation >> pointOfInterest: aTriasPointOfInterest [ 
	poi := TriasPointOfInterest 
]

{ #category : #printing }
TriasLocation >> printOn: aStream [
	aStream << 'Location: '.
	name printOn: aStream.
	locality ifNotNil: [ locality printOn: aStream ].
	stopPoint ifNotNil: [ stopPoint printOn: aStream ].
	poi ifNotNil: [ poi printOn: aStream ]
]

{ #category : #accessing }
TriasLocation >> stopPoint [
	^ stopPoint 
]

{ #category : #accessing }
TriasLocation >> stopPoint: aTriasStopPoint [ 
	stopPoint := aTriasStopPoint 
]
