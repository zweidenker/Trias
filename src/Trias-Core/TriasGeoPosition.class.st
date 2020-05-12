Class {
	#name : #TriasGeoPosition,
	#superclass : #TriasObject,
	#instVars : [
		'longitude',
		'latitude'
	],
	#category : #'Trias-Core'
}

{ #category : #'as yet unclassified' }
TriasGeoPosition class >> xmlElementName [
	^ 'GeoPosition'
]

{ #category : #accessing }
TriasGeoPosition >> latitude: aString [ 
	latitude := aString
]

{ #category : #accessing }
TriasGeoPosition >> longitude: aString [ 
	longitude := aString
]
