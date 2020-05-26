Class {
	#name : #TriasContentHandler,
	#superclass : #SAX2ContentHandler,
	#instVars : [
		'elementRootClass'
	],
	#category : #'Trias-Core-Base'
}

{ #category : #'as yet unclassified' }
TriasContentHandler >> elementRootClass [
	^ TriasObject
]

{ #category : #'handling - content' }
TriasContentHandler >> startElement: element attributes: attributes [ 
	| o |
	o := (self elementRootClass elementWithName: element) new.
	(self parser = self parser parsingResult)
		ifTrue: [ self parser parsingResult: o ]
		ifFalse: [ self parser parsingResult perform: element with: o ]
]
