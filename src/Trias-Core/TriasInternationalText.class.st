Class {
	#name : #TriasInternationalText,
	#superclass : #TriasObject,
	#instVars : [
		'text',
		'language'
	],
	#category : #'Trias-Core'
}

{ #category : #testing }
TriasInternationalText class >> isAbstract [ 
	^ self == TriasInternationalText
]

{ #category : #accessing }
TriasInternationalText >> language: aString [ 
	language := aString
]

{ #category : #printing }
TriasInternationalText >> printOn: aStream [
	aStream << text asString
]

{ #category : #accessing }
TriasInternationalText >> text: aString [ 
	text := aString
]
