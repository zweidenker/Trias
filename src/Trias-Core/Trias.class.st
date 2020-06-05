Class {
	#name : #Trias,
	#superclass : #Object,
	#instVars : [
		'locationResult',
		'schemas',
		'serviceDelivery',
		'trias'
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

{ #category : #'as yet unclassified' }
Trias >> serviceDelivery: aTriasServiceDelivery [ 
	serviceDelivery := aTriasServiceDelivery 
]

{ #category : #'as yet unclassified' }
Trias >> translateName: aString [ 
	^ aString
]

{ #category : #accessing }
Trias >> trias [

	^ trias
]

{ #category : #accessing }
Trias >> trias: anObject [

	trias := anObject
]
