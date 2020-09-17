Class {
	#name : #TriasRequestError,
	#superclass : #Error,
	#instVars : [
		'code',
		'text'
	],
	#category : #'Trias-Client'
}

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
