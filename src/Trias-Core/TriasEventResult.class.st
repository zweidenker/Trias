Class {
	#name : #TriasEventResult,
	#superclass : #TriasObject,
	#instVars : [
		'resultId',
		'operatingDayRef',
		'lineRef',
		'transportationMode',
		'transportationSubMode',
		'departure',
		'onwardDepartures'
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

{ #category : #accessing }
TriasEventResult >> departure [

	^ departure
]

{ #category : #accessing }
TriasEventResult >> departure: anEventDeparture [

	departure := anEventDeparture
]

{ #category : #initialization }
TriasEventResult >> initializeFromXML: anXMLElement [


	self resultId: (self extractValueFrom: anXMLElement element: 'ResultId').
	self departure: (TriasEventDeparture fromXML: (anXMLElement findElementNamed: 'ThisCall')).
	self onwardDepartures: ((anXMLElement allElementsNamed: 'OnwardCall') collect: [:each | TriasEventDeparture fromXML: each ]).
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
TriasEventResult >> onwardDepartures [

	^ onwardDepartures
]

{ #category : #accessing }
TriasEventResult >> onwardDepartures: aCollectionOfDepartures [

	onwardDepartures := aCollectionOfDepartures 
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

	^ self departure serviceDeparture
]

{ #category : #accessing }
TriasEventResult >> stopPointName [

	^ self departure stopPointName 
]

{ #category : #accessing }
TriasEventResult >> stopPointRef [

	^ self departure stopPointRef
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
