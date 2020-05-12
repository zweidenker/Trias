Class {
	#name : #TriasElement,
	#superclass : #TriasObject,
	#instVars : [
		'serviceDelivery'
	],
	#category : #'Trias-Core'
}

{ #category : #'as yet unclassified' }
TriasElement class >> xmlElementName [ 
	^ 'Trias'
]

{ #category : #accessing }
TriasElement >> serviceDelivery [
	^ serviceDelivery
]

{ #category : #'as yet unclassified' }
TriasElement >> serviceDelivery: aTriasServiceDelivery [ 
	serviceDelivery := aTriasServiceDelivery 
]
