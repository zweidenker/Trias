Class {
	#name : #TriasMode,
	#superclass : #TriasObject,
	#instVars : [
		'ptMode',
		'railSubmode',
		'busSubmode',
		'tramSubmode',
		'waterSubmode'
	],
	#category : #'Trias-Core'
}

{ #category : #'as yet unclassified' }
TriasMode class >> xmlElementName [ 
	^ 'Mode'
]

{ #category : #'as yet unclassified' }
TriasMode >> busSubmode: aString [ 
	busSubmode := aString
]

{ #category : #'as yet unclassified' }
TriasMode >> ptMode: aString [ 
	ptMode := aString
]

{ #category : #'as yet unclassified' }
TriasMode >> railSubmode: aString [ 
	railSubmode := aString
]

{ #category : #'as yet unclassified' }
TriasMode >> tramSubmode: aString [ 
	tramSubmode := aString
]

{ #category : #'as yet unclassified' }
TriasMode >> waterSubmode: aString [ 
	waterSubmode := aString
]
