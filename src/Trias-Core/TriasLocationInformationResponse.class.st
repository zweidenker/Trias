Class {
	#name : #TriasLocationInformationResponse,
	#superclass : #TriasObject,
	#instVars : [
		'locationResult',
		'locationResults'
	],
	#category : #'Trias-Core'
}

{ #category : #'as yet unclassified' }
TriasLocationInformationResponse class >> xmlElementName [
	^ 'LocationInformationResponse'
]

{ #category : #accessing }
TriasLocationInformationResponse >> locationResult: aTriasLocationResult [ 
	self locationResults add: aTriasLocationResult 
]

{ #category : #accessing }
TriasLocationInformationResponse >> locationResults [
	^ locationResults ifNil: [ 
		locationResults := OrderedCollection new ].
]

{ #category : #translating }
TriasLocationInformationResponse >> translateName: aString [ 
	(aString = 'Location') ifTrue: [ 
		^ 'LocationResult' ].
	^ aString
]
