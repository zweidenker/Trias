Class {
	#name : #TriasPointOfInterest,
	#superclass : #TriasObject,
	#instVars : [
		'code',
		'name',
		'localityRef'
	],
	#category : #'Trias-Core'
}

{ #category : #'as yet unclassified' }
TriasPointOfInterest class >> xmlElementName [ 
	^ 'PointOfInterest'
]

{ #category : #accessing }
TriasPointOfInterest >> localityRef: aString [ 
	localityRef := aString
]

{ #category : #accessing }
TriasPointOfInterest >> pointOfInterestCode: aString [ 
	code := aString
]

{ #category : #accessing }
TriasPointOfInterest >> pointOfInterestName: aTriasPointOfInterestName [ 
	name := aTriasPointOfInterestName 
]
