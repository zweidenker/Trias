Class {
	#name : #TriasSimpleClient,
	#superclass : #Object,
	#instVars : [
		'url',
		'timeout'
	],
	#classInstVars : [
		'requestorRef'
	],
	#category : #'Trias-Client'
}

{ #category : #accessing }
TriasSimpleClient class >> eventTypeArrival [

	"<xs:restriction base=""xs:string"">
			<xs:enumeration value=""departure""/>
			<xs:enumeration value=""arrival""/>
			<xs:enumeration value=""both""/>
		</xs:restriction>"
		
	^ 'arrival'.
]

{ #category : #accessing }
TriasSimpleClient class >> eventTypeBoth [

	"<xs:restriction base=""xs:string"">
			<xs:enumeration value=""departure""/>
			<xs:enumeration value=""arrival""/>
			<xs:enumeration value=""both""/>
		</xs:restriction>"
		
	^ 'both'.
]

{ #category : #accessing }
TriasSimpleClient class >> eventTypeDeparture [

	"<xs:restriction base=""xs:string"">
			<xs:enumeration value=""departure""/>
			<xs:enumeration value=""arrival""/>
			<xs:enumeration value=""both""/>
		</xs:restriction>"
		
	^ 'departure'.
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterEventsLocationId [

	^ #eventsLocationId
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterEventsNumberOfResults [

	^ #eventsNumberOfResults
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterEventsStartTimestamp [

	^ #eventsStartTimestamp
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterEventsTimeWindow [

	^ #eventsTimeWindow
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterEventsType [

	^ #eventsType
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterHookFor: aParameterName [

	^ '{{' , aParameterName , '}}'
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterLatitude [

	^ #latitude
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterLocationName [

	^ #locationName
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterLongitude [

	^ #longitude
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> parameterRequestorRef [

	^ #requestorRef
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> requestorRef [
	^ requestorRef ifNil: [ 
		Error signal: 'RequestorRef has to be set' ]
]

{ #category : #'accessing - request parameters' }
TriasSimpleClient class >> requestorRef: anObject [
	requestorRef := anObject
]

{ #category : #accessing }
TriasSimpleClient class >> scriptEventResponseXSD [
		| mainSchemaFile schemas element |
	mainSchemaFile := '../trias/Trias.xsd' asFileReference.
	schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
	element := ((schemas findElementNamed: #Trias) resolveElement: 'StopEventResponse').
]

{ #category : #accessing }
TriasSimpleClient class >> scriptGenerateEventRequestTemplate [
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
	req ServiceRequest RequestPayload StopEventRequest Params NumberOfResults: (self parameterHookFor: self parameterEventsNumberOfResults); TimeWindow: (self parameterHookFor: self parameterEventsTimeWindow); StopEventType: (self parameterHookFor: self parameterEventsType).
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
TriasSimpleClient class >> scriptGenerateStopFromAreaRequestTemplate [

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
TriasSimpleClient class >> scriptGenerateStopRequestTemplate [

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

{ #category : #'as yet unclassified' }
TriasSimpleClient >> dataRequestString [
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
TriasSimpleClient >> defaultRequestParameters [
	^ { 
		self class parameterRequestorRef  -> (self class requestorRef) } asDictionary 
]

{ #category : #requesting }
TriasSimpleClient >> execute: aRequestTemplateString with: mustacheParameters [

	| client response |
	client := ZnClient new 
		timeout: self timeout;
		url: self url;
		entity: (ZnEntity xml: (self process: aRequestTemplateString with: mustacheParameters)).
	response := client post.
	^response
]

{ #category : #requesting }
TriasSimpleClient >> getEventsFor: locationId timestamp: aDateAndTime till: aDurationString type: eventType limit: maximumNumberOfResults [
	| response triasDocument responseElement |
	response := self
		execute: self templateEventsRequest
		with:
			(self defaultRequestParameters
				at: self class parameterEventsLocationId put: locationId;
				at: self class parameterEventsStartTimestamp put: aDateAndTime printString;
				at: self class parameterEventsTimeWindow put: aDurationString;
				at: self class parameterEventsType put: eventType;
				at: self class parameterEventsNumberOfResults
					put: maximumNumberOfResults;
				yourself).
	triasDocument := XMLDOMParser parse: response.
	
	responseElement := (triasDocument findElementNamed: 'StopEventResponse').
	responseElement ifNil: [^ Error signal: 'Invalid Trias Request'].
	^ (responseElement allElementsNamed: 'StopEventResult') collect: [:eachXMLElement | 
		TriasEventResult fromXML: eachXMLElement
		].
]

{ #category : #requesting }
TriasSimpleClient >> getLocations: aLocationPatternString [

	| response triasDocument trias |
	response := self execute: self templateStopRequest with: (self defaultRequestParameters at: self class parameterLocationName put: aLocationPatternString ; yourself).
	triasDocument := XMLDOMParser parse: response.
	trias := TriasNodeVisitor new
		visitDocument: triasDocument.
	^ trias trias serviceDelivery deliveryPayload locationInformationResponse locationResults
]

{ #category : #requesting }
TriasSimpleClient >> getLocationsFromArea2: aPolygon [

	| response triasDocument trias |
	response := self execute: self templateStopFromAreaRequest with: (self defaultRequestParameters at: 'Points' put: (aPolygon coordinates collect: [ :eachPoint | { 'longitude' -> eachPoint x. 'latitude' -> eachPoint y } asDictionary ]) ; yourself).
	triasDocument := XMLDOMParser parse: response.
	trias := TriasNodeVisitor new
		visitDocument: triasDocument.
	self halt.
	^ trias trias serviceDelivery deliveryPayload locationInformationResponse locationResults
]

{ #category : #requesting }
TriasSimpleClient >> getLocationsFromArea: aPolygon [

	| response triasDocument trias mainSchemaFile schemas req area xml xmlString result |
	
	mainSchemaFile := 	'../trias/Trias.xsd' asFileReference.
	schemas := (XSDSchemaReader file: mainSchemaFile) schemas.
	req := (schemas findElementNamed: #Trias) newValue.
	req beSelfExpanding.
	req ServiceRequest RequestorRef: '3gG1pcgy89RB'.
	area := req ServiceRequest RequestPayload LocationInformationRequest InitialInput GeoRestriction Area. 
	result := OrderedCollection new.
	aPolygon coordinates do: [:each |

		result add: (area PolylinePoint Longitude: each x; Latitude: each y; yourself).
		 ].
	
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
	self halt.
	response := self execute: xmlString with: Dictionary new.
	triasDocument := XMLDOMParser parse: response.
	trias := TriasNodeVisitor new
		visitDocument: triasDocument.
	^ trias trias serviceDelivery deliveryPayload locationInformationResponse locationResults
]

{ #category : #requesting }
TriasSimpleClient >> getLocationsFromLongitude: aLongitude latitude: aLatitude radius: aRadiusInMeter [

	| response triasDocument trias |
	response := self execute: self templateStopFromCircleRequest with: (self defaultRequestParameters at: 'longitude' put: aLongitude ; at: 'latitude' put: aLatitude; at: 'radius' put: aRadiusInMeter; at: 'locationName' put: 'Karlsruhe';yourself).
	triasDocument := XMLDOMParser parse: response.
	trias := TriasNodeVisitor new
		visitDocument: triasDocument.
	self halt.
	^ trias trias serviceDelivery deliveryPayload locationInformationResponse locationResults
]

{ #category : #'as yet unclassified' }
TriasSimpleClient >> locationRequestString [
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
TriasSimpleClient >> locationRequestString2 [
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
TriasSimpleClient >> process: aString [ 
	^ aString asMustacheTemplate value: self requestParameters
]

{ #category : #'private - templates' }
TriasSimpleClient >> process: aString with: aDictionary [
	^ aString asMustacheTemplate value: aDictionary
]

{ #category : #'as yet unclassified' }
TriasSimpleClient >> requestData [

	| client response |
	client := ZnClient new 
		url: self url;
		entity: (ZnEntity xml: (self process: self dataRequestString)).
	response := client post.
	^response
]

{ #category : #'as yet unclassified' }
TriasSimpleClient >> requestLoca [

	| client response |
	client := ZnClient new 
		url: self url;
		entity: (ZnEntity xml: (self process: self locationRequestString)).
	response := client post.
	^response
]

{ #category : #'as yet unclassified' }
TriasSimpleClient >> requestParameters [
	^ { 
		#requestorRef -> (self class requestorRef) } asDictionary 
]

{ #category : #'as yet unclassified' }
TriasSimpleClient >> requestTrip [

	| client response |
	client := ZnClient new 
		url: self url;
		entity: (ZnEntity xml: (self process: self tripRequestString)).
	response := client post.
	^response
]

{ #category : #'private - templates' }
TriasSimpleClient >> templateEventsRequest [
"self scriptGenerateEventRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><StopEventRequest><Location><LocationRef><StopPointRef>{{eventsLocationId}}</StopPointRef></LocationRef><DepArrTime>{{eventsStartTimestamp}}</DepArrTime></Location><Params><NumberOfResults>{{eventsNumberOfResults}}</NumberOfResults><TimeWindow>{{eventsTimeWindow}}</TimeWindow><StopEventType>{{eventsType}}</StopEventType></Params></StopEventRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasSimpleClient >> templateStopFromAreaRequest [
"self scriptGenerateStopRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><LocationInformationRequest><InitialInput><GeoRestriction><Area>{{#Points}}<PolylinePoint><Longitude>{{longitude}}</Longitude><Latitude>{{latitude}}</Latitude></PolylinePoint>{{/Points}}</Area></GeoRestriction></InitialInput><Restrictions><IncludePtModes>true</IncludePtModes></Restrictions></LocationInformationRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasSimpleClient >> templateStopFromCircleRequest [
"self scriptGenerateStopCircleTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><LocationInformationRequest><InitialInput><LocationName>{{locationName}}</LocationName><GeoRestriction><Circle><Center><Longitude>{{longitude}}</Longitude><Latitude>{{latitude}}</Latitude></Center><Radius>{{radius}}</Radius></Circle></GeoRestriction></InitialInput><Restrictions><IncludePtModes>true</IncludePtModes></Restrictions></LocationInformationRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #'private - templates' }
TriasSimpleClient >> templateStopRequest [
"self scriptGenerateStopRequestTemplate"

^ '<?xml version="1.1" encoding="utf-8"?>
<Trias xmlns="http://www.vdv.de/trias" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.1"><ServiceRequest><RequestorRef xmlns="http://www.siri.org.uk/siri" xmlns:xsd="http://www.w3.org/2001/XMLSchema">{{requestorRef}}</RequestorRef><RequestPayload><LocationInformationRequest><InitialInput><LocationName>{{locationName}}</LocationName></InitialInput><Restrictions><IncludePtModes>true</IncludePtModes></Restrictions></LocationInformationRequest></RequestPayload></ServiceRequest></Trias>'
]

{ #category : #accessing }
TriasSimpleClient >> timeout [ 

	^ timeout ifNil: [ timeout :=  120 ]
]

{ #category : #accessing }
TriasSimpleClient >> timeout: aNumberOfSeconds [

	timeout := aNumberOfSeconds
]

{ #category : #'as yet unclassified' }
TriasSimpleClient >> tripRequestString [
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
TriasSimpleClient >> url [
	^ url
]

{ #category : #accessing }
TriasSimpleClient >> url: anObject [
	url := anObject
]
