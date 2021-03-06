Class {
	#name : #TriasClient,
	#superclass : #Object,
	#instVars : [
		'url',
		'timeout',
		'timeoutRetries'
	],
	#classInstVars : [
		'requestorRef'
	],
	#category : #'Trias-Client'
}

{ #category : #accessing }
TriasClient class >> eventTypeArrival [

	"<xs:restriction base=""xs:string"">
			<xs:enumeration value=""departure""/>
			<xs:enumeration value=""arrival""/>
			<xs:enumeration value=""both""/>
		</xs:restriction>"
		
	^ 'arrival'.
]

{ #category : #accessing }
TriasClient class >> eventTypeBoth [

	"<xs:restriction base=""xs:string"">
			<xs:enumeration value=""departure""/>
			<xs:enumeration value=""arrival""/>
			<xs:enumeration value=""both""/>
		</xs:restriction>"
		
	^ 'both'.
]

{ #category : #accessing }
TriasClient class >> eventTypeDeparture [

	"<xs:restriction base=""xs:string"">
			<xs:enumeration value=""departure""/>
			<xs:enumeration value=""arrival""/>
			<xs:enumeration value=""both""/>
		</xs:restriction>"
		
	^ 'departure'.
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterDestinationRef [

	^ #destinationRef
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterEventsLocationId [

	^ #eventsLocationId
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterEventsNumberOfResults [

	^ #eventsNumberOfResults
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterEventsOnwardCall [

	^ #eventsOwardCall
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterEventsStartTimestamp [

	^ #eventsStartTimestamp
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterEventsTimeWindow [

	^ #eventsTimeWindow
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterEventsType [

	^ #eventsType
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterHookFor: aParameterName [

	^ '{{' , aParameterName , '}}'
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterLatitude [

	^ #latitude
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterLocationName [

	^ #locationName
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterLocationRef [

	^ #locationRef
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterLongitude [

	^ #longitude
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterOriginRef [

	^ #originRef
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterRequestTimestamp [

	^ #requestTimestamp
]

{ #category : #'accessing - request parameters' }
TriasClient class >> parameterRequestorRef [

	^ #requestorRef
]

{ #category : #'accessing - request parameters' }
TriasClient class >> requestorRef [
	^ requestorRef ifNil: [ 
		Error signal: 'RequestorRef has to be set' ]
]

{ #category : #'accessing - request parameters' }
TriasClient class >> requestorRef: anObject [
	requestorRef := anObject
]

{ #category : #accessing }
TriasClient class >> scriptEventResponseXSD [
		| mainSchemaFile schemas element |
	mainSchemaFile := '../trias/Trias.xsd' asFileReference.
	schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
	element := ((schemas findElementNamed: #Trias) resolveElement: 'StopEventResponse').
]

{ #category : #accessing }
TriasClient class >> scriptGenerateBusTripRequestTemplate [

| mainSchemaFile schemas req xml xmlString xmString |
mainSchemaFile := 	'../trias/Trias.xsd' asFileReference.
schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
		
req := (schemas findElementNamed: #Trias) newValue.
req beSelfExpanding.
req ServiceRequest RequestorRef: (self parameterHookFor: self parameterRequestorRef).
req ServiceRequest RequestPayload TripRequest Origin LocationRef StopPointRef: (self parameterHookFor: self parameterOriginRef).
req ServiceRequest RequestPayload TripRequest Origin DepArrTime: (self parameterHookFor: self parameterRequestTimestamp ).
req ServiceRequest RequestPayload TripRequest Destination LocationRef StopPointRef: (self parameterHookFor: self parameterDestinationRef).
"
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
		</xs:restriction>'"
req ServiceRequest RequestPayload TripRequest Params PtModeFilter Exclude: false ;PtMode: 'bus' ; BusSubmode: 'regionalBus' ; BusSubmode: 'localBus' ; BusSubmode: 'demandAndResponseBus' .
req ServiceRequest RequestPayload TripRequest Params InterchangeLimit: '0'.
req ServiceRequest RequestPayload TripRequest Params AlgorithmType: 'minChanges'.
req ServiceRequest RequestPayload TripRequest Params IncludeTrackSections: true.
req ServiceRequest RequestPayload TripRequest Params IncludeLegProjection: true.
req ServiceRequest RequestPayload TripRequest Params IncludeIntermediateStops: false.
req ServiceRequest RequestPayload TripRequest Params IncludeOperatingDays: false.
req ServiceRequest RequestPayload TripRequest Params IncludeFares: true.



xml := PluggableXMLVisitor new
	visit: req name: 'Trias';
	document.
	
xml 
	version: '1.1';
	encoding: 'utf-8'.
xml root attributeAt: 'version' put: '1.1'.

^ String streamContents: [ :stream | | writer |
	writer := (XMLWriter on: stream)
		enablePrologPrettyPrinting.
	xml writeXMLOn: writer ].



]

{ #category : #accessing }
TriasClient class >> scriptGenerateEventRequestTemplate [
	| mainSchemaFile schemas req xml xmlString |
	mainSchemaFile := '../trias/Trias.xsd' asFileReference.
	schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
	req := (schemas findElementNamed: #Trias) newValue.
	req beSelfExpanding.
	req ServiceRequest RequestorRef: (self parameterHookFor: self parameterRequestorRef).
	req ServiceRequest RequestPayload StopEventRequest Location
		LocationRef StopPointRef:  (self parameterHookFor: self parameterEventsLocationId).
	req ServiceRequest RequestPayload StopEventRequest Location
		DepArrTime:  (self parameterHookFor: self parameterEventsStartTimestamp).
	req ServiceRequest RequestPayload StopEventRequest Params NumberOfResults: (self parameterHookFor: self parameterEventsNumberOfResults); TimeWindow: (self parameterHookFor: self parameterEventsTimeWindow); IncludeOnwardCalls: (self parameterHookFor: self parameterEventsOnwardCall); StopEventType: (self parameterHookFor: self parameterEventsType).
	xml := PluggableXMLVisitor new
		visit: req name: 'Trias';
		document.
	xml
		version: '1.1';
		encoding: 'utf-8'.
	xml root attributeAt: 'version' put: '1.1'.
	xmlString := String
		streamContents: [ :stream | 
			| writer |
			writer := (XMLWriter on: stream) enablePrologPrettyPrinting.
			xml writeXMLOn: writer ]
]

{ #category : #accessing }
TriasClient class >> scriptGenerateStopFromAreaRequestTemplate [

| response triasDocument trias mainSchemaFile schemas req area xml xmlString result aPolygon polyline |
	
	mainSchemaFile := 	'../trias/Trias.xsd' asFileReference.
	schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
	req := (schemas findElementNamed: #Trias) newValue.
	req beSelfExpanding.
	req ServiceRequest RequestorRef: (self parameterHookFor: self parameterRequestorRef).
	area := req ServiceRequest RequestPayload LocationInformationRequest InitialInput GeoRestriction Area PolylinePoint Longitude: (self parameterHookFor: self parameterLongitude); Latitude: (self parameterHookFor: self parameterLatitude); yourself. 
	
	req ServiceRequest RequestPayload LocationInformationRequest Restrictions IncludePtModes: 'true'.
	xml := PluggableXMLVisitor new
	visit: req name: 'Trias';
	document.
	
xml 
	version: '1.1';
	encoding: 'utf-8'.
xml root attributeAt: 'version' put: '1.1'.

xmlString := String streamContents: [ :stream | | writer |
	writer := (XMLWriter on: stream)
		enablePrologPrettyPrinting.
	xml writeXMLOn: writer ].
]

{ #category : #accessing }
TriasClient class >> scriptGenerateStopRefinementRequestTemplate [

		| mainSchemaFile schemas req xml xmlString |
	mainSchemaFile := 	'../trias/Trias.xsd' asFileReference.
schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
		
req := (schemas findElementNamed: #Trias) newValue.
req beSelfExpanding.
req ServiceRequest RequestorRef: (self parameterHookFor: self parameterRequestorRef).
req ServiceRequest RequestPayload LocationInformationRequest LocationRef StopPointRef: (self parameterHookFor: self parameterLocationRef).
xml := PluggableXMLVisitor new
	visit: req name: 'Trias';
	document.
	
xml 
	version: '1.1';
	encoding: 'utf-8'.
xml root attributeAt: 'version' put: '1.1'.

xmlString := String streamContents: [ :stream | | writer |
	writer := (XMLWriter on: stream)
		enablePrologPrettyPrinting.
	xml writeXMLOn: writer ].

^ xmlString
]

{ #category : #accessing }
TriasClient class >> scriptGenerateStopRequestTemplate [

		| mainSchemaFile schemas req xml xmlString |
	mainSchemaFile := 	'../trias/Trias.xsd' asFileReference.
schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
		
req := (schemas findElementNamed: #Trias) newValue.
req beSelfExpanding.
req ServiceRequest RequestorRef: (self parameterHookFor: self parameterRequestorRef).
req ServiceRequest RequestPayload LocationInformationRequest InitialInput LocationName: (self parameterHookFor: self parameterLocationName).
req ServiceRequest RequestPayload LocationInformationRequest Restrictions IncludePtModes: 'true'.
xml := PluggableXMLVisitor new
	visit: req name: 'Trias';
	document.
	
xml 
	version: '1.1';
	encoding: 'utf-8'.
xml root attributeAt: 'version' put: '1.1'.

xmlString := String streamContents: [ :stream | | writer |
	writer := (XMLWriter on: stream)
		enablePrologPrettyPrinting.
	xml writeXMLOn: writer ].

^ xmlString
]

{ #category : #accessing }
TriasClient class >> scriptGenerateTripRequestTemplate [

| mainSchemaFile schemas req xml xmlString xmString |
mainSchemaFile := 	'../trias/Trias.xsd' asFileReference.
schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
		
req := (schemas findElementNamed: #Trias) newValue.
req beSelfExpanding.
req ServiceRequest RequestorRef: (self parameterHookFor: self parameterRequestorRef).
req ServiceRequest RequestPayload TripRequest Origin LocationRef StopPointRef: (self parameterHookFor: self parameterOriginRef).
req ServiceRequest RequestPayload TripRequest Origin DepArrTime: (self parameterHookFor: self parameterRequestTimestamp ).
req ServiceRequest RequestPayload TripRequest Destination LocationRef StopPointRef: (self parameterHookFor: self parameterDestinationRef).
"
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
		</xs:restriction>'"
"req ServiceRequest RequestPayload TripRequest Params PtModeFilter Exclude: true;PtMode: 'all'."
req ServiceRequest RequestPayload TripRequest Params InterchangeLimit: '0'.
req ServiceRequest RequestPayload TripRequest Params AlgorithmType: 'minChanges'.
req ServiceRequest RequestPayload TripRequest Params IncludeTrackSections: true.
req ServiceRequest RequestPayload TripRequest Params IncludeLegProjection: true.
req ServiceRequest RequestPayload TripRequest Params IncludeIntermediateStops: false.
req ServiceRequest RequestPayload TripRequest Params IncludeOperatingDays: false.
req ServiceRequest RequestPayload TripRequest Params IncludeFares: true.



xml := PluggableXMLVisitor new
	visit: req name: 'Trias';
	document.
	
xml 
	version: '1.1';
	encoding: 'utf-8'.
xml root attributeAt: 'version' put: '1.1'.

^ String streamContents: [ :stream | | writer |
	writer := (XMLWriter on: stream)
		enablePrologPrettyPrinting.
	xml writeXMLOn: writer ].



]

{ #category : #'as yet unclassified' }
TriasClient >> dataRequestString [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias version="1.1" xmlns="http://www.vdv.de/trias" xmlns:siri="http://www.siri.org.uk/siri" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vdv.de/trias file:///C:/development/HEAD/extras/TRIAS/TRIAS_1.1/Trias.xsd">
    <ServiceRequest>
        <siri:RequestTimeStamp>2020-02-11T16:41:17</siri:RequestTimeStamp>
        <siri:RequestorRef>{{requestorRef}}</siri:RequestorRef>
        <RequestPayload>
				<VehicleDataRequest>
					<VehicleStatus>false</VehicleStatus>
					<VehicleActivity>false</VehicleActivity>
				</VehicleDataRequest>
        </RequestPayload>
    </ServiceRequest>
</Trias>'
]

{ #category : #accessing }
TriasClient >> defaultRequestParameters [
	^ { 
		self class parameterRequestorRef  -> (self class requestorRef) } asDictionary 
]

{ #category : #requesting }
TriasClient >> execute: aRequestTemplateString with: mustacheParameters [

	^ self execute: aRequestTemplateString with: mustacheParameters attempt: 1
]

{ #category : #requesting }
TriasClient >> execute: aRequestTemplateString with: mustacheParameters attempt: aNumber [
	| client response |
	client := ZnClient new
		timeout: self timeout;
		url: self url;
		entity:
			(ZnEntity
				xml: (self process: aRequestTemplateString with: mustacheParameters)).
	response := [ client post ]
		on: ConnectionTimedOut , ZnUnknownHttpVersion  , NameLookupFailure
		do: [ :ex | 
			 (aNumber > self timeoutRetries)
				ifTrue: [ ex pass ]
				ifFalse: [ ^ self
						execute: aRequestTemplateString
						with: mustacheParameters
						attempt: aNumber + 1 ] ].
	^ response
]

{ #category : #requesting }
TriasClient >> getBusTripFrom: anOriginStopPointRef to: aDestinationStopPointRef [

	^ self getBusTripFrom: anOriginStopPointRef to: aDestinationStopPointRef at: DateAndTime now
]

{ #category : #requesting }
TriasClient >> getBusTripFrom: anOriginStopPointRef to: aDestinationStopPointRef at: aDateAndTime [

	^ self getTrip: self templateBusTripRequest from: anOriginStopPointRef to: aDestinationStopPointRef at: aDateAndTime
]

{ #category : #requesting }
TriasClient >> getEventsFor: locationId timestamp: aDateAndTime till: aDurationString type: eventType limit: maximumNumberOfResults [

		^ self getEventsFor: locationId timestamp: aDateAndTime till: aDurationString type: eventType limit: maximumNumberOfResults onwardDepartures: false
]

{ #category : #requesting }
TriasClient >> getEventsFor: locationId timestamp: aDateAndTime till: aDurationString type: eventType limit: maximumNumberOfResults onwardDepartures: aBoolean [
	| response triasDocument responseElement |
	response := self
		execute: self templateEventsRequestWithOnwardDepartures
		with:
			(self defaultRequestParameters
				at: self class parameterEventsLocationId put: locationId;
				at: self class parameterEventsStartTimestamp
					put: aDateAndTime printString;
				at: self class parameterEventsOnwardCall
					put: aBoolean;
				at: self class parameterEventsTimeWindow put: aDurationString;
				at: self class parameterEventsType put: eventType;
				at: self class parameterEventsNumberOfResults
					put: maximumNumberOfResults;
				yourself).
	triasDocument := XMLDOMParser parse: response.
	responseElement := triasDocument
		findElementNamed: 'StopEventResponse'.
	responseElement ifNil: [ ^ Error signal: 'Invalid Trias Request' ].
	self handleErrorIn: responseElement.
	^ (responseElement allElementsNamed: 'StopEventResult')
		asOrderedCollection
		collect: [ :eachXMLElement | TriasEventResult fromXML: eachXMLElement ]
]

{ #category : #requesting }
TriasClient >> getLocationRefinement: aLocationId [

	| response triasDocument trias |
	response := self execute: self templateRefinementStopRequest  with: (self defaultRequestParameters at: self class parameterLocationRef  put: aLocationId ; yourself).
	triasDocument := XMLDOMParser parse: response.
	self handleErrorIn: triasDocument.
	trias := TriasNodeVisitor new
		visitDocument: triasDocument.
	^ trias trias serviceDelivery deliveryPayload locationInformationResponse locationResults first "there should be only one result for a refinement request"
]

{ #category : #requesting }
TriasClient >> getLocations: aLocationPatternString [

	| response triasDocument trias |
	response := self execute: self templateStopRequest with: (self defaultRequestParameters at: self class parameterLocationName put: aLocationPatternString ; yourself).
	triasDocument := XMLDOMParser parse: response.
	trias := TriasNodeVisitor new
		visitDocument: triasDocument.
	^ trias trias serviceDelivery deliveryPayload locationInformationResponse locationResults
]

{ #category : #requesting }
TriasClient >> getLocationsFromArea: aPolygon [

	| response triasDocument trias |
	response := self execute: self templateStopFromAreaRequest with: (self defaultRequestParameters at: 'Points' put: (aPolygon coordinates collect: [ :eachPoint | { 'longitude' -> eachPoint x. 'latitude' -> eachPoint y } asDictionary ]) ; yourself).
	triasDocument := XMLDOMParser parse: response.
	trias := TriasNodeVisitor new
		visitDocument: triasDocument.
	^ trias trias serviceDelivery deliveryPayload locationInformationResponse locationResults
]

{ #category : #requesting }
TriasClient >> getLocationsFromLongitude: aLongitude latitude: aLatitude radius: aRadiusInMeter [

	| response triasDocument trias |
	response := self execute: self templateStopFromCircleRequest with: (self defaultRequestParameters at: 'longitude' put: aLongitude ; at: 'latitude' put: aLatitude; at: 'radius' put: aRadiusInMeter; at: 'locationName' put: 'Karlsruhe';yourself).
	triasDocument := XMLDOMParser parse: response.
	trias := TriasNodeVisitor new
		visitDocument: triasDocument.
	^ trias trias serviceDelivery deliveryPayload locationInformationResponse locationResults
]

{ #category : #requesting }
TriasClient >> getTrip: requestTemplate from: anOriginStopPointRef to: aDestinationStopPointRef at: aDateAndTime [

	| response triasDocument responseElement |
	response := self execute: requestTemplate with: (self defaultRequestParameters at: self class parameterOriginRef  put: anOriginStopPointRef ;
	at: self class parameterDestinationRef  put: aDestinationStopPointRef ;
	at: self class parameterRequestTimestamp put: aDateAndTime printString ;
	 yourself).
	triasDocument := XMLDOMParser parse: response.

	responseElement := (triasDocument findElementNamed: 'TripResponse').
	responseElement ifNil: [^ Error signal: 'Invalid Trias Request'].
	^ (responseElement allElementsNamed: 'TripResult') asOrderedCollection collect: [:eachXMLElement | 
		TriasTripResult fromXML: eachXMLElement
		].
]

{ #category : #requesting }
TriasClient >> getTripFrom: anOriginStopPointRef to: aDestinationStopPointRef [

	^ self getTripFrom: anOriginStopPointRef to: aDestinationStopPointRef at: DateAndTime now
]

{ #category : #requesting }
TriasClient >> getTripFrom: anOriginStopPointRef to: aDestinationStopPointRef at: aDateAndTime [

	^ self getTrip: self templateTripRequest from: anOriginStopPointRef to: aDestinationStopPointRef at: aDateAndTime
]

{ #category : #requesting }
TriasClient >> handleErrorIn: responseElement [
	(responseElement findElementNamed: 'ErrorMessage')
		ifNotNil: [ :errorElement | 
			(errorElement elementAt: 'Code')
				ifNotNil: [ :codeElement | 
					(TriasRequestError errorFromCode:  codeElement strings anyOne) 
						text: ((errorElement elementAt: 'Text') elementAt: 'Text') strings anyOne;
						signal ] ]
]

{ #category : #'as yet unclassified' }
TriasClient >> locationRequestString [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias version="1.1" xmlns="http://www.vdv.de/trias" xmlns:siri="http://www.siri.org.uk/siri" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vdv.de/trias file:///C:/development/HEAD/extras/TRIAS/TRIAS_1.1/Trias.xsd">
    <ServiceRequest>
        <siri:RequestTimeStamp>2020-02-19T14:41:17</siri:RequestTimeStamp>
        <siri:RequestorRef>{{requestorRef}}</siri:RequestorRef>
        <RequestPayload>
            <LocationInformationRequest>
     				<InitialInput>
						<LocationName>Karlsruhe</LocationName>
					</InitialInput>
            </LocationInformationRequest>
        </RequestPayload>
    </ServiceRequest>
</Trias>'
]

{ #category : #'as yet unclassified' }
TriasClient >> locationRequestString2 [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias version="1.1" xmlns="http://www.vdv.de/trias" xmlns:siri="http://www.siri.org.uk/siri" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vdv.de/trias file:///C:/development/HEAD/extras/TRIAS/TRIAS_1.1/Trias.xsd">
    <ServiceRequest>
        <siri:RequestTimeStamp>2020-02-19T14:41:17</siri:RequestTimeStamp>
        <siri:RequestorRef>{{requestorRef}}</siri:RequestorRef>
        <RequestPayload>
            <LocationInformationRequest>
     				<InitialInput>
						<GeoPosition>
							<Longitude>8.400921</Longitude>
							<Latitude>48.994150</Latitude>
						</GeoPosition>
					</InitialInput>
            </LocationInformationRequest>
        </RequestPayload>
    </ServiceRequest>
</Trias>'
]

{ #category : #'as yet unclassified' }
TriasClient >> process: aString [ 
	^ aString asMustacheTemplate value: self requestParameters
]

{ #category : #'private - templates' }
TriasClient >> process: aString with: aDictionary [
	^ aString asMustacheTemplate value: aDictionary
]

{ #category : #'as yet unclassified' }
TriasClient >> requestData [

	| client response |
	client := ZnClient new 
		url: self url;
		entity: (ZnEntity xml: (self process: self dataRequestString)).
	response := client post.
	^response
]

{ #category : #'as yet unclassified' }
TriasClient >> requestLoca [

	| client response |
	client := ZnClient new 
		url: self url;
		entity: (ZnEntity xml: (self process: self locationRequestString)).
	response := client post.
	^response
]

{ #category : #'as yet unclassified' }
TriasClient >> requestParameters [
	^ { 
		#requestorRef -> (self class requestorRef) } asDictionary 
]

{ #category : #'as yet unclassified' }
TriasClient >> requestTrip [

	| client response |
	client := ZnClient new 
		url: self url;
		entity: (ZnEntity xml: (self process: self tripRequestString)).
	response := client post.
	^response
]

{ #category : #'private - templates' }
TriasClient >> templateBusTripRequest [
"self scriptGenerateBusTripRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><TripRequest><Origin><LocationRef><StopPointRef>{{originRef}}</StopPointRef></LocationRef><DepArrTime>{{requestTimestamp}}</DepArrTime></Origin><Destination><LocationRef><StopPointRef>{{destinationRef}}</StopPointRef></LocationRef></Destination><Params><PtModeFilter><Exclude>false</Exclude><PtMode>bus</PtMode><BusSubmode>regionalBus</BusSubmode><BusSubmode>localBus</BusSubmode> <BusSubmode>demandAndResponseBus</BusSubmode></PtModeFilter><InterchangeLimit>0</InterchangeLimit><AlgorithmType>minChanges</AlgorithmType><IncludeTrackSections>true</IncludeTrackSections><IncludeLegProjection>true</IncludeLegProjection><IncludeIntermediateStops>false</IncludeIntermediateStops><IncludeOperatingDays>false</IncludeOperatingDays><IncludeFares>true</IncludeFares></Params></TripRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasClient >> templateEventsRequest [
"self scriptGenerateEventRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><StopEventRequest><Location><LocationRef><StopPointRef>{{eventsLocationId}}</StopPointRef></LocationRef><DepArrTime>{{eventsStartTimestamp}}</DepArrTime></Location><Params><NumberOfResults>{{eventsNumberOfResults}}</NumberOfResults><TimeWindow>{{eventsTimeWindow}}</TimeWindow><StopEventType>{{eventsType}}</StopEventType></Params></StopEventRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasClient >> templateEventsRequestWithOnwardDepartures [
"self scriptGenerateEventRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><StopEventRequest><Location><LocationRef><StopPointRef>{{eventsLocationId}}</StopPointRef></LocationRef><DepArrTime>{{eventsStartTimestamp}}</DepArrTime></Location><Params><NumberOfResults>{{eventsNumberOfResults}}</NumberOfResults><TimeWindow>{{eventsTimeWindow}}</TimeWindow><IncludeOnwardCalls>{{eventsOwardCall}}</IncludeOnwardCalls><StopEventType>{{eventsType}}</StopEventType></Params></StopEventRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasClient >> templateRefinementStopRequest [
"self scriptGenerateStopRefinementRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><LocationInformationRequest><LocationRef><StopPointRef>{{locationRef}}</StopPointRef></LocationRef></LocationInformationRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasClient >> templateStopFromAreaRequest [
"self scriptGenerateStopRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><LocationInformationRequest><InitialInput><GeoRestriction><Area>{{#Points}}<PolylinePoint><Longitude>{{longitude}}</Longitude><Latitude>{{latitude}}</Latitude></PolylinePoint>{{/Points}}</Area></GeoRestriction></InitialInput><Restrictions><IncludePtModes>true</IncludePtModes></Restrictions></LocationInformationRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasClient >> templateStopFromCircleRequest [
"self scriptGenerateStopCircleTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><LocationInformationRequest><InitialInput><LocationName>{{locationName}}</LocationName><GeoRestriction><Circle><Center><Longitude>{{longitude}}</Longitude><Latitude>{{latitude}}</Latitude></Center><Radius>{{radius}}</Radius></Circle></GeoRestriction></InitialInput><Restrictions><IncludePtModes>true</IncludePtModes></Restrictions></LocationInformationRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasClient >> templateStopRequest [
"self scriptGenerateStopRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><LocationInformationRequest><InitialInput><LocationName>{{locationName}}</LocationName></InitialInput><Restrictions><IncludePtModes>true</IncludePtModes></Restrictions></LocationInformationRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasClient >> templateTripRequest [
"self scriptGenerateTripRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><TripRequest><Origin><LocationRef><StopPointRef>{{originRef}}</StopPointRef></LocationRef><DepArrTime>{{requestTimestamp}}</DepArrTime></Origin><Destination><LocationRef><StopPointRef>{{destinationRef}}</StopPointRef></LocationRef></Destination><Params><InterchangeLimit>0</InterchangeLimit><AlgorithmType>minChanges</AlgorithmType><IncludeTrackSections>true</IncludeTrackSections><IncludeLegProjection>true</IncludeLegProjection><IncludeIntermediateStops>false</IncludeIntermediateStops><IncludeOperatingDays>false</IncludeOperatingDays><IncludeFares>true</IncludeFares></Params></TripRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #accessing }
TriasClient >> timeout [ 

	^ timeout ifNil: [ timeout :=  120 ]
]

{ #category : #accessing }
TriasClient >> timeout: aNumberOfSeconds [

	timeout := aNumberOfSeconds
]

{ #category : #accessing }
TriasClient >> timeoutRetries [
	"sometimes it might help to retry a request after getting a timeout.
	By default do not attempt any retry"
	^ timeoutRetries ifNil: [ 0 ]
]

{ #category : #accessing }
TriasClient >> timeoutRetries: aNumber [

	timeoutRetries := aNumber
]

{ #category : #'as yet unclassified' }
TriasClient >> tripRequestString [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias version="1.1" xmlns="http://www.vdv.de/trias" xmlns:siri="http://www.siri.org.uk/siri" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vdv.de/trias file:///C:/development/HEAD/extras/TRIAS/TRIAS_1.1/Trias.xsd">
    <ServiceRequest>
        <siri:RequestTimeStamp>2020-02-11T16:41:17</siri:RequestTimeStamp>
        <siri:RequestorRef>{{requestorRef}}</siri:RequestorRef>
        <RequestPayload>
            <TripRequest>
                <Origin>
                    <LocationRef>
                        <StopPlaceRef>de:08212:7</StopPlaceRef>
                    </LocationRef>
                    <DepArrTime>2020-02-11T17:00:00</DepArrTime>
                </Origin>
                <Destination>
                    <LocationRef>
                        <StopPlaceRef>de:08212:89</StopPlaceRef>
                    </LocationRef>
                </Destination>
                <Params>
                    <NumberOfResults>10</NumberOfResults>
                    <IncludeTrackSections>false</IncludeTrackSections>
                    <IncludeLegProjection>false</IncludeLegProjection>
                    <IncludeIntermediateStops>false</IncludeIntermediateStops>
                    <IncludeOperatingDays>false</IncludeOperatingDays>
                    <IncludeFares>true</IncludeFares>
                </Params>
            </TripRequest>
        </RequestPayload>
    </ServiceRequest>
</Trias>'
]

{ #category : #accessing }
TriasClient >> url [
	^ url
]

{ #category : #accessing }
TriasClient >> url: anObject [
	url := anObject
]
