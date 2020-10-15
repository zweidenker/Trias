Class {
	#name : #TriasRequestError,
	#superclass : #Error,
	#instVars : [
		'code',
		'text'
	],
	#category : #'Trias-Client'
}

{ #category : #accessing }
TriasRequestError class >> errorClassForCode: aCode [

	^ self subclasses detect: [ :each | each triasCode = aCode ] ifNone: [ self ]
]

{ #category : #'instance creation' }
TriasRequestError class >> errorFromCode: aTriasCodeString [
	^ (self errorClassForCode: aTriasCodeString) new
		code: aTriasCodeString;
		yourself
]

{ #category : #acccessing }
TriasRequestError >> code [ 

	^ code
]

{ #category : #acccessing }
TriasRequestError >> code: aString [

	code := aString
]

{ #category : #acccessing }
TriasRequestError >> messageText [ 

	^ 'Trias responded with error ' , code , ' : ' , text
]

{ #category : #acccessing }
TriasRequestError >> text [

	^ text 
]

{ #category : #acccessing }
TriasRequestError >> text: aString [

	text := aString
]
