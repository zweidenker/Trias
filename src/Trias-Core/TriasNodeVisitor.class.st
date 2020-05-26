Class {
	#name : #TriasNodeVisitor,
	#superclass : #XMLNodeVisitor,
	#instVars : [
		'currentObject'
	],
	#category : #'Trias-Core-Visitor'
}

{ #category : #visiting }
TriasNodeVisitor >> visitDocument: aDocument [
	currentObject := TriasValueHolder new.
	self visitNodeWithElements: aDocument.
	^ currentObject trias
]

{ #category : #visiting }
TriasNodeVisitor >> visitElement: anElement [
	| name object value |
	name := currentObject 
		ifNotNil: [ 
			currentObject translateName: anElement name ]
		ifNil: [ anElement name ].
	anElement hasElements
		ifTrue: [   
			object := (TriasObject elementWithName: name) new.
			value := self 
				withCurrent: object
				visit: [ self visitNodeWithElements: anElement ].
			value := object ]
		ifFalse: [ value := anElement contentString ].
	currentObject 
		ifNotNil: [  
			currentObject 
				perform: name asValidSelector asMutator
				with: value ].
	^ value
]

{ #category : #'as yet unclassified' }
TriasNodeVisitor >> withCurrent: anObject visit: aBlock [
	| previousObject |
	previousObject := currentObject.
	currentObject := anObject.
	[ ^ aBlock value ]
		ensure: [ currentObject := previousObject ]
]
