Class {
	#name : #TriasEventResult,
	#superclass : #TriasObject,
	#instVars : [
		'resultId',
		'stopPointRef',
		'stopPointName',
		'serviceDeparture',
		'operatingDayRef',
		'lineRef',
		'transportationMode',
		'transportationSubMode'
	],
	#category : #'Trias-Core-Model'
}

{ #category : #'instance creation' }
TriasEventResult class >> fromXML: anXMLElement [

	^ self new
		initializeFromXML: anXMLElement;
		yourself
]

{ #category : #'as yet unclassified' }
TriasEventResult class >> xmlElementName [
	^ 'EventResult'
]

{ #category : #initialization }
TriasEventResult >> initializeFromXML: anXMLElement [


	self resultId: (self extractValueFrom: anXMLElement element: 'ResultId').
	self stopPointRef: (self extractValueFrom: anXMLElement element: 'StopPointRef').
	self stopPointName: (self extractValueFrom:(anXMLElement findElementNamed: 'StopPointName') element: 'Text').
	self serviceDeparture: (self extractValueFrom: (anXMLElement findElementNamed: 'ServiceDeparture') element: 'TimetabledTime' convert: [:string | DateAndTime fromString: string ]).
	self operatingDayRef:  (self extractValueFrom: anXMLElement element: 'OperatingDayRef' convert: [:string | Date fromString: string]).
	self lineRef:  (self extractValueFrom: anXMLElement element: 'LineRef').
	self transportationMode:  (self extractValueFrom: anXMLElement element: 'PtMode').
	(self extractOptionalValueFrom: anXMLElement element: 'RailSubmode') ifNotNil: [ :aString | self transportationSubMode: aString ].
	(self extractOptionalValueFrom: anXMLElement element: 'BusSubmode') ifNotNil: [ :aString | self transportationSubMode: aString ].
	(self extractOptionalValueFrom: anXMLElement element: 'TramSubmode') ifNotNil: [ :aString | self transportationSubMode: aString ].
	
	
]

{ #category : #accessing }
TriasEventResult >> lineRef [

	^ lineRef
]

{ #category : #accessing }
TriasEventResult >> lineRef: aString [

	lineRef := aString
]

{ #category : #accessing }
TriasEventResult >> operatingDayRef [

	^ operatingDayRef
]

{ #category : #accessing }
TriasEventResult >> operatingDayRef: aDate [

	operatingDayRef := aDate
]

{ #category : #accessing }
TriasEventResult >> resultId [

	^ resultId
]

{ #category : #accessing }
TriasEventResult >> resultId: aString [

	resultId := aString
]

{ #category : #accessing }
TriasEventResult >> serviceDeparture [

	^ serviceDeparture
]

{ #category : #accessing }
TriasEventResult >> serviceDeparture: aDateAndTime [

	serviceDeparture := aDateAndTime
]

{ #category : #accessing }
TriasEventResult >> stopPointName [

	^ stopPointName 
]

{ #category : #accessing }
TriasEventResult >> stopPointName: aString [

	stopPointName := aString
]

{ #category : #accessing }
TriasEventResult >> stopPointRef [

	^ stopPointRef
]

{ #category : #accessing }
TriasEventResult >> stopPointRef: aString [

	stopPointRef := aString
]

{ #category : #accessing }
TriasEventResult >> transportationMode [
	"<xs:simpleType name=""PtModesEnumeration"">
		<xs:annotation>
			<xs:documentation>Allowed values for MODES: TPEG pti_table 01.</xs:documentation>
		</xs:annotation>
		<xs:restriction base=""xs:NMTOKEN"">
			<xs:enumeration value=""all""/>
			<xs:enumeration value=""unknown""/>
			<xs:enumeration value=""air""/>
			<xs:enumeration value=""bus""/>
			<xs:enumeration value=""trolleyBus""/>
			<xs:enumeration value=""tram""/>
			<xs:enumeration value=""coach""/>
			<xs:enumeration value=""rail""/>
			<xs:enumeration value=""intercityRail""/>
			<xs:enumeration value=""urbanRail""/>
			<xs:enumeration value=""metro""/>
			<xs:enumeration value=""water""/>
			<xs:enumeration value=""cableway""/>
			<xs:enumeration value=""funicular""/>
			<xs:enumeration value=""taxi""/>
		</xs:restriction>
	</xs:simpleType>
	
	see https://github.com/VDVde/TRIAS/blob/master/Trias_ModesSupport.xsd
	
	"

	^ transportationMode
]

{ #category : #accessing }
TriasEventResult >> transportationMode: aString [

	transportationMode := aString
]

{ #category : #accessing }
TriasEventResult >> transportationSubMode [

	^ transportationSubMode
]

{ #category : #accessing }
TriasEventResult >> transportationSubMode: aString [

	transportationSubMode := aString
]
