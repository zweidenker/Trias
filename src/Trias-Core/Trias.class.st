Class {
	#name : #Trias,
	#superclass : #Object,
	#instVars : [
		'locationResult',
		'schemas'
	],
	#classInstVars : [
		'current'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #accessing }
Trias class >> current [
	^ current ifNil: [ 
		current := self new ]
]

{ #category : #accessing }
Trias >> locationResult: aResult [
	locationResult := aResult
]

{ #category : #accessing }
Trias >> schemas: aXSDSchemaSet [ 
	schemas := aXSDSchemaSet 
]
