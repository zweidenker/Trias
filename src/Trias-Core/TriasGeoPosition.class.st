Class {
	#name : #TriasGeoPosition,
	#superclass : #TriasObject,
	#instVars : [
		'longitude',
		'latitude'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'as yet unclassified' }
TriasGeoPosition class >> xmlElementName [
	^ 'GeoPosition'
]

{ #category : #accessing }
TriasGeoPosition >> latitude [
	^ latitude
]

{ #category : #accessing }
TriasGeoPosition >> latitude: aString [ 
	latitude := aString
]

{ #category : #accessing }
TriasGeoPosition >> longitude [
	^ longitude
]

{ #category : #accessing }
TriasGeoPosition >> longitude: aString [ 
	longitude := aString
]
