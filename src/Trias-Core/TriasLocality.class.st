Class {
	#name : #TriasLocality,
	#superclass : #TriasObject,
	#instVars : [
		'code',
		'name'
	],
	#category : #'Trias-Core'
}

{ #category : #'as yet unclassified' }
TriasLocality class >> xmlElementName [
	^ 'Locality'
]

{ #category : #accessing }
TriasLocality >> localityCode: aString [ 
	code := aString
]

{ #category : #'as yet unclassified' }
TriasLocality >> localityName: aTriasLocalityName [ 
	name := aTriasLocalityName 
]

{ #category : #printing }
TriasLocality >> printOn: aStream [
	aStream << 'Locality: ' << name asString << ' (' << code asString  << ')'
]
