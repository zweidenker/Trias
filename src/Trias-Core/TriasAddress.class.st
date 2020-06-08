Class {
	#name : #TriasAddress,
	#superclass : #TriasObject,
	#instVars : [
		'addressCode',
		'postalCode',
		'localityName',
		'localityRef',
		'streetName',
		'addressName'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'as yet unclassified' }
TriasAddress class >> xmlElementName [ 
	^ 'Address'
]

{ #category : #accessing }
TriasAddress >> addressCode [
	^ addressCode 
]

{ #category : #accessing }
TriasAddress >> addressCode: anObject [
	addressCode := anObject
]

{ #category : #accessing }
TriasAddress >> addressName [
	^ addressName 
]

{ #category : #accessing }
TriasAddress >> addressName: anObject [
	addressName := anObject
]

{ #category : #accessing }
TriasAddress >> localityName [
	^ localityName 
]

{ #category : #accessing }
TriasAddress >> localityName: anObject [
	localityName := anObject
]

{ #category : #accessing }
TriasAddress >> localityRef [
	^ localityRef 
]

{ #category : #accessing }
TriasAddress >> localityRef: anObject [
	localityRef := anObject
]

{ #category : #accessing }
TriasAddress >> postalCode [
	^ postalCode 
]

{ #category : #accessing }
TriasAddress >> postalCode: anObject [
	postalCode := anObject
]

{ #category : #accessing }
TriasAddress >> streetName [
	^ streetName 
]

{ #category : #accessing }
TriasAddress >> streetName: anObject [
	streetName := anObject
]
