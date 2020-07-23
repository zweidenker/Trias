Class {
	#name : #TriasObject,
	#superclass : #Object,
	#category : #'Trias-Core-Model'
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

{ #category : #utilities }
TriasObject >> extractOptionalValueFrom: anXMLElement element: elementName [ 

	^ self extractOptionalValueFrom: anXMLElement element: elementName convert: #yourself
]

{ #category : #utilities }
TriasObject >> extractOptionalValueFrom: anXMLElement element: elementName convert: converter [
	^  self extractValueFrom: anXMLElement element: elementName convert: converter ifAbsent: [ nil ]
]

{ #category : #utilities }
TriasObject >> extractValueFrom: anXMLElement element: elementName [ 

	^ self extractValueFrom: anXMLElement element: elementName convert: #yourself
]

{ #category : #utilities }
TriasObject >> extractValueFrom: anXMLElement element: elementName convert: converter [
	^  self extractValueFrom: anXMLElement element: elementName convert: converter ifAbsent: [ Error signal: ('Element ' , elementName printString , ' not found in ' , anXMLElement printString) ]
]

{ #category : #utilities }
TriasObject >> extractValueFrom: anXMLElement element: elementName convert: converter ifAbsent: aBlock [
	^ (anXMLElement findElementNamed: elementName)
		ifNil: [ aBlock value ]
		ifNotNil: [ :element | converter value: element contentString ]
]

{ #category : #utilities }
TriasObject >> extractValueFrom: anXMLElement element: elementName ifAbsent: aBlock [

	^ self extractValueFrom: anXMLElement element: elementName convert: #yourself ifAbsent: aBlock
]

{ #category : #translating }
TriasObject >> translateName: aString [ 
	^ aString
]
