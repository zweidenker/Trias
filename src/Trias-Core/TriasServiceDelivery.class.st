Class {
	#name : #TriasServiceDelivery,
	#superclass : #TriasObject,
	#instVars : [
		'timestamp',
		'status',
		'moreData',
		'language',
		'deliveryPayload'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'as yet unclassified' }
TriasServiceDelivery class >> xmlElementName [ 
	^ 'ServiceDelivery'
]

{ #category : #accessing }
TriasServiceDelivery >> deliveryPayload [
	^ deliveryPayload
]

{ #category : #accessing }
TriasServiceDelivery >> deliveryPayload: aTriasDeliveryPayload [ 
	deliveryPayload := aTriasDeliveryPayload 
]

{ #category : #accessing }
TriasServiceDelivery >> language: aString [ 
	language := aString
]

{ #category : #accessing }
TriasServiceDelivery >> moreData: aString [ 
	moreData := aString = 'true'
]

{ #category : #accessing }
TriasServiceDelivery >> producerRef: aString [ 
]

{ #category : #accessing }
TriasServiceDelivery >> responseTimestamp: aString [ 
	timestamp := DateAndTime fromString: aString
]

{ #category : #accessing }
TriasServiceDelivery >> status: aString [ 
	status := aString
]
