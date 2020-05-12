Class {
	#name : #TriasObject,
	#superclass : #Object,
	#category : #'Trias-Core'
}

{ #category : #'as yet unclassified' }
TriasObject class >> elementWithName: aString [ 
	^ (self allSubclasses reject: #isAbstract)
		detect: [ :each | each xmlElementName = aString ]
]

{ #category : #testing }
TriasObject class >> isAbstract [ 
	^ self == TriasObject
]

{ #category : #'as yet unclassified' }
TriasObject class >> xmlElementName [
	self subclassResponsibility 
]

{ #category : #translating }
TriasObject >> translateName: aString [ 
	^ aString
]
