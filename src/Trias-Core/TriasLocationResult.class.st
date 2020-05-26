Class {
	#name : #TriasLocationResult,
	#superclass : #TriasObject,
	#instVars : [
		'location',
		'complete',
		'probability',
		'mode'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'as yet unclassified' }
TriasLocationResult class >> xmlElementName [ 
	^ 'LocationResult'
]

{ #category : #accessing }
TriasLocationResult >> complete: aString [ 
	complete := aString = 'true'
]

{ #category : #'as yet unclassifiedtesting' }
TriasLocationResult >> isNotComplete [
	^ complete not
]

{ #category : #accessing }
TriasLocationResult >> location [
	^ location
]

{ #category : #'as yet unclassified' }
TriasLocationResult >> location: aTriasLocation [ 
	location := aTriasLocation 
]

{ #category : #accessing }
TriasLocationResult >> mode: aTriasMode [ 
	mode := aTriasMode 
]

{ #category : #printing }
TriasLocationResult >> printOn: aStream [
	location printOn: aStream.
	aStream << ', complete: ' << complete asString
]

{ #category : #accessing }
TriasLocationResult >> probability: aString [ 
	probability := aString 
]
