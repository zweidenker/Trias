Class {
	#name : #TriasStopPoint,
	#superclass : #TriasObject,
	#instVars : [
		'reference',
		'name',
		'localityReference'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'as yet unclassified' }
TriasStopPoint class >> xmlElementName [
	^ 'StopPoint'
]

{ #category : #accessing }
TriasStopPoint >> localityRef [
	^ localityReference 
]

{ #category : #accessing }
TriasStopPoint >> localityRef: aString [ 
	localityReference := aString
]

{ #category : #printing }
TriasStopPoint >> printOn: aStream [
	aStream << ' StopPoint: '.
	name printOn: aStream.
	aStream << '(' << reference asString << ', ' << localityReference asString << ') '.
	
]

{ #category : #accessing }
TriasStopPoint >> stopPointName [
	^ name 
]

{ #category : #accessing }
TriasStopPoint >> stopPointName: aTriasStopPointName [ 
	name := aTriasStopPointName 
]

{ #category : #accessing }
TriasStopPoint >> stopPointRef [
	^ reference 
]

{ #category : #accessing }
TriasStopPoint >> stopPointRef: aString [ 
	reference := aString
]
