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
			package: 'Trias-Core' with: [ spec requires: #('XMLParser') ];
			package: 'Trias-Client' with: [ spec requires: #('Trias-Core' 'Mustache') ];
			package: 'Trias-Schema' with: [ spec requires: #('Trias-Core' 'Trias-Client' 'XMLSchema') ];
			package: 'Trias-Core-Tests' with: [ spec requires: #('Trias-Core') ].

		spec
			group: 'default' with: #('Trias-Core' 'Trias-Client' 'Trias-Schema' 'Tests');
			group: 'Tests' with: #('Trias-Core-Tests');
			group: 'Core' with: #('Trias-Core');
			group: 'Client' with: #('Trias-Client').

		self
			xmlParser: spec;
			xpath: spec;
			mustache: spec;
			xmlSchema: spec ]

]

{ #category : #dependencies }
BaselineOfTrias >> mustache: spec [

	spec
		baseline: 'Mustache' with: [ 
			spec 
				repository: 'github://noha/mustache:v1.0.1/repository';
				loads: #( 'Core' )].
			
	
]

{ #category : #dependencies }
BaselineOfTrias >> xmlParser: spec [

	spec
		baseline: 'XMLParser' with: [ 
			spec 
				loads: 'Core';
				repository: 'github://pharo-contributions/XML-XMLParser:3.5.0/src'].
			
	
]

{ #category : #dependencies }
BaselineOfTrias >> xmlSchema: spec [

	spec
		baseline: 'XMLSchema' with: [ 
			spec 
				repository: 'github://noha/XML-Schema/src'].
			
	
]

{ #category : #dependencies }
BaselineOfTrias >> xpath: spec [

	spec
		baseline: 'XPath' with: [ 
			spec 
				repository: 'github://pharo-contributions/XML-XPath/src'].
			

]
