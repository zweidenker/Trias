Class {
	#name : #BaselineOfTrias,
	#superclass : #BaselineOf,
	#category : #BaselineOfTrias
}

{ #category : #baselines }
BaselineOfTrias >> baseline: spec [
	<baseline>
	spec for: #common do: [
   		spec
			package: 'Trias-Core' with: [ spec requires: #('XMLParser' 'Mustache') ];
			package: 'Trias-Core-Tests' with: [ spec requires: #('Trias-Core') ].

		spec
			group: 'default' with: #('Trias-Core' 'Trias-Core-Tests');
			group: 'Core' with: #('Trias-Core').

		self
			xmlParser: spec;
			xpath: spec;
			mustache: spec ]

]

{ #category : #dependencies }
BaselineOfTrias >> mustache: spec [

	spec
		baseline: 'Mustache' with: [ 
			spec 
				repository: 'github://noha/mustache:v1.0.1/repository'].
			
	
]

{ #category : #dependencies }
BaselineOfTrias >> xmlParser: spec [

	spec
		baseline: 'XMLParser' with: [ 
			spec 
				repository: 'github://pharo-contributions/XML-XMLParser:3.5.0/src'].
			
	
]

{ #category : #dependencies }
BaselineOfTrias >> xpath: spec [

	spec
		baseline: 'XPath' with: [ 
			spec 
				repository: 'github://pharo-contributions/XML-XPath/src'].
			

]
