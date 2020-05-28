Class {
	#name : #TriasValueHolder,
	#superclass : #Object,
	#instVars : [
		'trias'
	],
	#category : #'Trias-Core-Base'
}

{ #category : #'as yet unclassified' }
TriasValueHolder >> serviceDelivery: aTriasServiceDelivery [ 
	trias serviceDelivery: aTriasServiceDelivery 
]

{ #category : #'as yet unclassified' }
TriasValueHolder >> translateName: aString [ 
	^ aString
]

{ #category : #accessing }
TriasValueHolder >> trias [
	^ trias
]

{ #category : #accessing }
TriasValueHolder >> trias: aTriasElement [ 
	trias := aTriasElement 
]
