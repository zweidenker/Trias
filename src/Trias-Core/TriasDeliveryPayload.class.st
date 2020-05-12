Class {
	#name : #TriasDeliveryPayload,
	#superclass : #TriasObject,
	#instVars : [
		'locationInformationResponse'
	],
	#category : #'Trias-Core'
}

{ #category : #'as yet unclassified' }
TriasDeliveryPayload class >> xmlElementName [
	^ 'DeliveryPayload'
]

{ #category : #accessing }
TriasDeliveryPayload >> locationInformationResponse [
	^ locationInformationResponse
]

{ #category : #accessing }
TriasDeliveryPayload >> locationInformationResponse: aTriasLocationInformationResponse [ 
	locationInformationResponse := aTriasLocationInformationResponse 
]
