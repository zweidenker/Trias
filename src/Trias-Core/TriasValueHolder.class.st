Class {
	#name : #TriasValueHolder,
	#superclass : #Object,
	#instVars : [
		'trias'
	],
	#category : #'Trias-Core-Base'
}

{ #category : #accessing }
TriasValueHolder >> trias [
	^ trias
]

{ #category : #accessing }
TriasValueHolder >> trias: aTriasElement [ 
	trias := aTriasElement 
]
