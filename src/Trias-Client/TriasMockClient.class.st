Class {
	#name : #TriasMockClient,
	#superclass : #TriasClient,
	#instVars : [
		'mockResponses',
		'repeatedMockResponses'
	],
	#category : #'Trias-Client'
}

{ #category : #accessing }
TriasMockClient class >> requestorRef [

	^ ''
]

{ #category : #'private - mocking' }
TriasMockClient >> addRepeatedResponseForRequest: aRequestTemplateAccessor shouldBe: aValue [
	((repeatedMockResponses at: (self perform: aRequestTemplateAccessor) put: aValue)).
]

{ #category : #'private - mocking' }
TriasMockClient >> addResponseForRequest: aRequestTemplateAccessor shouldBe: aBlock [
	(self mockResponsesAt: (self perform: aRequestTemplateAccessor)) nextPut: aBlock.
]

{ #category : #requesting }
TriasMockClient >> execute: aTemplateString with: mustacheParameters [

	^ ((self mockResponsesAt: aTemplateString) nextIfNone: [ 
		(repeatedMockResponses at: aTemplateString ifAbsent: [
			Error signal: 'missing mocked response for ', aTemplateString printString]) value 
			]) 
		
]

{ #category : #initialization }
TriasMockClient >> initialize [
	super initialize.
	mockResponses := 
		Dictionary new.
	repeatedMockResponses := Dictionary new
]

{ #category : #'services - mocking' }
TriasMockClient >> installMockStop: aString [
	
	self 
		addResponseForRequest: #templateStopRequest 
	 	shouldBe: [aString ]
]

{ #category : #'services - mocking' }
TriasMockClient >> installMockStopEvent [
	
	self installRepeatedMockStop: self mockForStopEvent 
]

{ #category : #'services - mocking' }
TriasMockClient >> installMockStopPfizer [
	
	self installRepeatedMockStop: self mockForStopPfizer 
]

{ #category : #'services - mocking' }
TriasMockClient >> installRepeatedMockStop: aString [
	
	self 
		addRepeatedResponseForRequest: #templateStopRequest 
	 	shouldBe: aString 
]

{ #category : #'private - mocking' }
TriasMockClient >> mockForStopEvent [

	^ '<? xml version = "1.0" encoding = "UTF-8"?>
<Trias xmlns = "http://www.vdv.de/trias" version = "1.1">
   <ServiceDelivery>
      <ResponseTimestamp xmlns = "http://www.siri.org.uk/siri"> 2021-03-25T09: 53: 02Z </ResponseTimestamp>
      <ProducerRef xmlns = "http://www.siri.org.uk/siri"> EFAController10.3.17.15-EFA03 </ProducerRef>
      <Status xmlns = "http://www.siri.org.uk/siri"> true </Status>
      <MoreData> false </MoreData>
      <Language> de </Language>
      <DeliveryPayload>
         <StopEventResponse>
            <StopEventResponseContext>
               <Situations />
            </StopEventResponseContext>
            <StopEventResult>
               <ResultId> ID-98280E11-0C07-47BE-BE5C-20750835DA9D </ResultId>
               <StopEvent>
                  <ThisCall>
                     <CallAtStop>
                        <StopPointRef> de: 08212: 3105: 0: 2 </StopPointRef>
                        <StopPointName>
                           <Text> Hagsfeld Pfizer </Text>
                           <Language> de </Language>
                        </StopPointName>
                        <ServiceDeparture>
                           <TimetabledTime> 2021-01-25T03: 05: 00Z </TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber> 4 </StopSeqNumber>
                     </CallAtStop>
                  </ThisCall>
                  <OnwardCall>
                     <CallAtStop>
                        <StopPointRef> de: 08212: 3102: 12: 12 </StopPointRef>
                        <StopPointName>
                           <Text> Hagsfeld Bahnhof </Text>
                           <Language> de </Language>
                        </StopPointName>
                        <ServiceArrival>
                           <TimetabledTime> 2021-01-25T03: 06: 00Z </TimetabledTime>
                        </ServiceArrival>
                        <ServiceDeparture>
                           <TimetabledTime> 2021-01-25T03: 06: 00Z </TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber> 2 </StopSeqNumber>
                     </CallAtStop>
                  </OnwardCall>
                  <OnwardCall>
                     <CallAtStop>
                        <StopPointRef> de: 08212: 3104: 0: 2 </StopPointRef>
                        <StopPointName>
                           <Text> Hagsfeld Julius-Bender-Straße </Text>
                           <Language> de </Language>
                        </StopPointName>
                        <ServiceArrival>
                           <TimetabledTime> 2021-01-25T03: 07: 00Z </TimetabledTime>
                        </ServiceArrival>
                        <ServiceDeparture>
                           <TimetabledTime> 2021-01-25T03: 07: 00Z </TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber> 3 </StopSeqNumber>
                     </CallAtStop>
                  </OnwardCall>
                  <Service>
                     <OperatingDayRef> 2021-01-25 </OperatingDayRef>
                     <JourneyRef> kvv: 03094: E: H: j21: 24 </JourneyRef>
                     <LineRef> kvv: 03094: E: H </LineRef>
                     <DirectionRef> outward </DirectionRef>
                     <Mode>
                        <PtMode> bus </PtMode>
                        <BusSubmode> localBus </BusSubmode>
                        <name>
                           <Text> Nightliner </Text>
                           <Language> de </Language>
                        </name>
                     </Mode>
                     <PublishedLineName>
                        <Text> Nightliner NL4 </Text>
                        <Language> de </Language>
                     </PublishedLineName>
                     <OperatorRef> kvv: 02 </OperatorRef>
                     <RouteDescription>
                        <Text> Hagsfeld - Waldstadt - Marktplatz </Text>
                        <Language> de </Language>
                     </RouteDescription>
                     <Attribute>
                        <text>
                           <Text> Low-floor wagon </Text>
                           <Language> de </Language>
                        </Text>
                        <Code> 126887 </Code>
                        <Mandatory> false </Mandatory>
                     </Attribute>
                     <OriginStopPointRef> de: 08212: 3109: 0: 2 </OriginStopPointRef>
                     <OriginText>
                        <Text> Hagsfeld Storrenacker Süd </Text>
                        <Language> de </Language>
                     </OriginText>
                     <DestinationText>
                        <Text> NL 4 Marketplace </Text>
                        <Language> de </Language>
                     </DestinationText>
                  </Service>
               </StopEvent>
            </StopEventResult>
         </StopEventResponse>
      </DeliveryPayload>
   </ServiceDelivery>
</Trias>'
]

{ #category : #'private - mocking' }
TriasMockClient >> mockForStopEventWithDuplicatedCoordinates [

	^ '<? xml version = "1.0" encoding = "UTF-8"?>
<Trias xmlns = "http://www.vdv.de/trias" version = "1.1">
   <ServiceDelivery>
      <ResponseTimestamp xmlns = "http://www.siri.org.uk/siri"> 2021-03-25T09: 53: 02Z </ResponseTimestamp>
      <ProducerRef xmlns = "http://www.siri.org.uk/siri"> EFAController10.3.17.15-EFA03 </ProducerRef>
      <Status xmlns = "http://www.siri.org.uk/siri"> true </Status>
      <MoreData> false </MoreData>
      <Language> de </Language>
      <DeliveryPayload>
         <StopEventResponse>
            <StopEventResponseContext>
               <Situations />
            </StopEventResponseContext>
            <StopEventResult>
               <ResultId> ID-98280E11-0C07-47BE-BE5C-20750835DA9D </ResultId>
               <StopEvent>
                  <ThisCall>
                     <CallAtStop>
                        <StopPointRef> de: 08212: 3105: 0: 2 </StopPointRef>
                        <StopPointName>
                           <Text> Hagsfeld Pfizer </Text>
                           <Language> de </Language>
                        </StopPointName>
                        <ServiceDeparture>
                           <TimetabledTime> 2021-01-25T03: 05: 00Z </TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber> 4 </StopSeqNumber>
                     </CallAtStop>
                  </ThisCall>
                  <OnwardCall>
                     <CallAtStop>
                        <StopPointRef> de: 08212: 3102: 12: 12 </StopPointRef>
                        <StopPointName>
                           <Text> Hagsfeld Bahnhof </Text>
                           <Language> de </Language>
                        </StopPointName>
                        <ServiceArrival>
                           <TimetabledTime> 2021-01-25T03: 06: 00Z </TimetabledTime>
                        </ServiceArrival>
                        <ServiceDeparture>
                           <TimetabledTime> 2021-01-25T03: 06: 00Z </TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber> 2 </StopSeqNumber>
                     </CallAtStop>
                  </OnwardCall>
                  <OnwardCall>
                     <CallAtStop>
                        <StopPointRef> de: 08212: 3104: 0: 2 </StopPointRef>
                        <StopPointName>
                           <Text> Hagsfeld Julius-Bender-Straße </Text>
                           <Language> de </Language>
                        </StopPointName>
                        <ServiceArrival>
                           <TimetabledTime> 2021-01-25T03: 07: 00Z </TimetabledTime>
                        </ServiceArrival>
                        <ServiceDeparture>
                           <TimetabledTime> 2021-01-25T03: 07: 00Z </TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber> 3 </StopSeqNumber>
                     </CallAtStop>
                  </OnwardCall>
                  <Service>
                     <OperatingDayRef> 2021-01-25 </OperatingDayRef>
                     <JourneyRef> kvv: 03094: E: H: j21: 24 </JourneyRef>
                     <LineRef> kvv: 03094: E: H </LineRef>
                     <DirectionRef> outward </DirectionRef>
                     <Mode>
                        <PtMode> bus </PtMode>
                        <BusSubmode> localBus </BusSubmode>
                        <name>
                           <Text> Nightliner </Text>
                           <Language> de </Language>
                        </name>
                     </Mode>
                     <PublishedLineName>
                        <Text> Nightliner NL4 </Text>
                        <Language> de </Language>
                     </PublishedLineName>
                     <OperatorRef> kvv: 02 </OperatorRef>
                     <RouteDescription>
                        <Text> Hagsfeld - Waldstadt - Marktplatz </Text>
                        <Language> de </Language>
                     </RouteDescription>
                     <Attribute>
                        <text>
                           <Text> Low-floor wagon </Text>
                           <Language> de </Language>
                        </Text>
                        <Code> 126887 </Code>
                        <Mandatory> false </Mandatory>
                     </Attribute>
                     <OriginStopPointRef> de: 08212: 3109: 0: 2 </OriginStopPointRef>
                     <OriginText>
                        <Text> Hagsfeld Storrenacker Süd </Text>
                        <Language> de </Language>
                     </OriginText>
                     <DestinationText>
                        <Text> NL 4 Marketplace </Text>
                        <Language> de </Language>
                     </DestinationText>
                  </Service>
               </StopEvent>
            </StopEventResult>
         </StopEventResponse>
      </DeliveryPayload>
   </ServiceDelivery>
</Trias>'
]

{ #category : #'private - mocking' }
TriasMockClient >> mockForStopPfizer [

	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias xmlns="http://www.vdv.de/trias" version="1.1"><ServiceDelivery><ResponseTimestamp xmlns="http://www.siri.org.uk/siri">2021-03-15T16:28:11Z</ResponseTimestamp><ProducerRef xmlns="http://www.siri.org.uk/siri">EFAController10.3.17.13-EFA-REALTIME</ProducerRef><Status xmlns="http://www.siri.org.uk/siri">true</Status><MoreData>false</MoreData><Language>de</Language><DeliveryPayload><LocationInformationResponse><Location><Location><StopPoint><StopPointRef>de:08212:3105</StopPointRef><StopPointName><Text>Pfizer</Text><Language>de</Language></StopPointName><LocalityRef>8212000:12</LocalityRef></StopPoint><LocationName><Text>Hagsfeld</Text><Language>de</Language></LocationName><GeoPosition><Longitude>8.45325</Longitude><Latitude>49.02357</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>1</Probability><Mode><PtMode>bus</PtMode><BusSubmode>localBus</BusSubmode></Mode></Location><Location><Location><Address><AddressCode>streetID:1500001302::8212000:-1:Pfizerstraße:Karlsruhe:Pfizerstraße::Pfizerstraße: 76139:ANY:DIVA_STREET:941263:5721286:MRCV:B_W</AddressCode><AddressName><Text>Karlsruhe, Pfizerstraße</Text><Language>de</Language></AddressName><PostalCode> 76139</PostalCode><LocalityName>Karlsruhe</LocalityName><LocalityRef>8212000:-1</LocalityRef><StreetName>Pfizerstraße</StreetName></Address><LocationName><Text>Karlsruhe</Text><Language>de</Language></LocationName><GeoPosition><Longitude>8.45551</Longitude><Latitude>49.02270</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.957000017</Probability></Location><Location><Location><PointOfInterest><PointOfInterestCode>poiID:1000111087:8212000:-1:Karl-Pfizer-Anlage:Karlsruhe:Karl-Pfizer-Anlage:ANY:POI:941473:5720694:MRCV:B_W</PointOfInterestCode><PointOfInterestName><Text>Karlsruhe, Karl-Pfizer-Anlage</Text><Language>de</Language></PointOfInterestName><LocalityRef>8212000:-1</LocalityRef></PointOfInterest><LocationName><Text>Karlsruhe</Text><Language>de</Language></LocationName><GeoPosition><Longitude>8.45740</Longitude><Latitude>49.02619</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.93599999</Probability></Location><Location><Location><Address><AddressCode>streetID:1500000580::8416041:-1:Pfizerstraße:Tübingen:Pfizerstraße::Pfizerstraße: 72070:ANY:DIVA_STREET:1007377:5805650:MRCV:B_W</AddressCode><AddressName><Text>Tübingen, Pfizerstraße</Text><Language>de</Language></AddressName><PostalCode> 72070</PostalCode><LocalityName>Tübingen</LocalityName><LocalityRef>8416041:-1</LocalityRef><StreetName>Pfizerstraße</StreetName></Address><LocationName><Text>Tübingen</Text><Language>de</Language></LocationName><GeoPosition><Longitude>9.04942</Longitude><Latitude>48.52325</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.957000017</Probability></Location><Location><Location><Address><AddressCode>streetID:1500000775::8121000:-1:Pfizerstraße:Heilbronn:Pfizerstraße::Pfizerstraße: 74074:ANY:DIVA_STREET:1027657:5702483:MRCV:B_W</AddressCode><AddressName><Text>Heilbronn, Pfizerstraße</Text><Language>de</Language></AddressName><PostalCode> 74074</PostalCode><LocalityName>Heilbronn</LocalityName><LocalityRef>8121000:-1</LocalityRef><StreetName>Pfizerstraße</StreetName></Address><LocationName><Text>Heilbronn</Text><Language>de</Language></LocationName><GeoPosition><Longitude>9.23160</Longitude><Latitude>49.13334</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.957000017</Probability></Location><Location><Location><Address><AddressCode>streetID:1500002345::8111000:-1:Pfizerstraße:Stuttgart:Pfizerstraße::Pfizerstraße: 70184:ANY:DIVA_STREET:1023053:5763314:MRCV:B_W</AddressCode><AddressName><Text>Stuttgart, Pfizerstraße</Text><Language>de</Language></AddressName><PostalCode> 70184</PostalCode><LocalityName>Stuttgart</LocalityName><LocalityRef>8111000:-1</LocalityRef><StreetName>Pfizerstraße</StreetName></Address><LocationName><Text>Stuttgart</Text><Language>de</Language></LocationName><GeoPosition><Longitude>9.19024</Longitude><Latitude>48.77451</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.957000017</Probability></Location><Location><Location><Address><AddressCode>streetID:1500000800::8415061:-1:Paul-Pfizer-Straße:Reutlingen:Paul-Pfizer-Straße::Paul-Pfizer-Straße: 72762:ANY:DIVA_STREET:1024828:5812270:MRCV:B_W</AddressCode><AddressName><Text>Reutlingen, Paul-Pfizer-Straße</Text><Language>de</Language></AddressName><PostalCode> 72762</PostalCode><LocalityName>Reutlingen</LocalityName><LocalityRef>8415061:-1</LocalityRef><StreetName>Paul-Pfizer-Straße</StreetName></Address><LocationName><Text>Reutlingen</Text><Language>de</Language></LocationName><GeoPosition><Longitude>9.20619</Longitude><Latitude>48.48384</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.935000002</Probability></Location></LocationInformationResponse></DeliveryPayload></ServiceDelivery></Trias>'
]

{ #category : #requesting }
TriasMockClient >> mockResponsesAt: aTemplateString [
	
	^ mockResponses at: aTemplateString ifAbsentPut: [WaitfreeQueue new]
]
