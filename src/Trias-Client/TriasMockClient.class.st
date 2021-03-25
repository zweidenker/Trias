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

{ #category : #'private - mock installing' }
TriasMockClient >> addRepeatedResponseForRequest: aRequestTemplateAccessor shouldBe: aValue [
	((repeatedMockResponses at: (self perform: aRequestTemplateAccessor) put: aValue)).
]

{ #category : #'private - mock installing' }
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

{ #category : #'private - mock installing' }
TriasMockClient >> installMockStop: aString [
	
	self 
		addResponseForRequest: #templateStopRequest 
	 	shouldBe: [aString ]
]

{ #category : #'private - mock installing' }
TriasMockClient >> installMockStopEvent: aString [
	
	self 
		addResponseForRequest: #templateEventsRequestWithOnwardDepartures 
	 	shouldBe: aString 
]

{ #category : #'services - mocking' }
TriasMockClient >> installMockStopEventsOver: aNumberOfDays from: aDateAndTime [
	
	self resetMockStopEvent.
	self installMockStopEvent: (self mockForStopEventAt: aDateAndTime).  
	(1 to: aNumberOfDays) do: [ :eachIndex |
			self installMockStopEvent: (self mockForStopEventAt: (aDateAndTime + eachIndex days) asDateAndTime  )
		 ] 

]

{ #category : #'services - mocking' }
TriasMockClient >> installMockStopEventsUnservedLocation [

	self resetMockStopEvent.
	self
		installRepeatedMockStopEvent: self mockForStopEventUnservedLocation
]

{ #category : #'services - mocking' }
TriasMockClient >> installMockStopPfizer [
	
	self installRepeatedMockStop: self mockForStopPfizer 
]

{ #category : #'private - mock installing' }
TriasMockClient >> installMockStopRefinement: aString [
	
	self 
		addResponseForRequest: #templateRefinementStopRequest 
	 	shouldBe: aString 
]

{ #category : #'services - mocking' }
TriasMockClient >> installMockStopRefinementAtLatitude: aLatitude longitude: aLongitue [
	
	
	self installRepeatedMockStopRefinement: (self mockForStopRefinementAtLatitude: aLatitude longitude: aLongitue) 

]

{ #category : #'services - mocking' }
TriasMockClient >> installMockStopRefinementAtRandomLocations: aNumberOfMocks [
	1 to: aNumberOfMocks do: [ :eachIndex | 
		self
			installMockStopRefinement:
				(self
					mockForStopRefinementAtLatitude: '45.' , (eachIndex asString padLeftTo: 5 with: $0)
					longitude: '8.' , (eachIndex asString padLeftTo: 5 with: $0)) ]
]

{ #category : #'services - mocking' }
TriasMockClient >> installMockTrip [
	
	self installRepeatedMockTrip: self mockForTrip
]

{ #category : #'private - mock installing' }
TriasMockClient >> installRepeatedMockStop: aString [
	
	self 
		addRepeatedResponseForRequest: #templateStopRequest 
	 	shouldBe: aString 
]

{ #category : #'private - mock installing' }
TriasMockClient >> installRepeatedMockStopEvent: aString [
	
	self 
		addRepeatedResponseForRequest: #templateEventsRequestWithOnwardDepartures 
	 	shouldBe: aString 
]

{ #category : #'private - mock installing' }
TriasMockClient >> installRepeatedMockStopRefinement: aString [
	
	self 
		addRepeatedResponseForRequest: #templateRefinementStopRequest 
	 	shouldBe: aString 
]

{ #category : #'private - mock installing' }
TriasMockClient >> installRepeatedMockTrip: aString [
	
	self 
		addRepeatedResponseForRequest: #templateTripRequest 
	 	shouldBe: aString 
]

{ #category : #'private - mocking' }
TriasMockClient >> mockForStopEventAt: aDateAndTime [

	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias xmlns="http://www.vdv.de/trias" version="1.1">
   <ServiceDelivery>
      <ResponseTimestamp xmlns="http://www.siri.org.uk/siri"> 2021-03-25T09: 53: 02Z </ResponseTimestamp>
      <ProducerRef xmlns="http://www.siri.org.uk/siri"> EFAController10.3.17.15-EFA03 </ProducerRef>
      <Status xmlns="http://www.siri.org.uk/siri"> true </Status>
      <MoreData> false </MoreData>
      <Language> de </Language>
      <DeliveryPayload>
         <StopEventResponse>
            <StopEventResponseContext>
               <Situations />
            </StopEventResponseContext>
            <StopEventResult>
               <ResultId>ID-98280E11-0C07-47BE-BE5C-20750835DA9D</ResultId>
               <StopEvent>
                  <ThisCall>
                     <CallAtStop>
                        <StopPointRef>de:08212:3105:0:2</StopPointRef>
                        <StopPointName>
                           <Text>Hagsfeld Pfizer</Text>
                           <Language>de</Language>
                        </StopPointName>
                        <ServiceDeparture>
                           <TimetabledTime>', aDateAndTime printString,'</TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber>4</StopSeqNumber>
                     </CallAtStop>
                  </ThisCall>
                  <OnwardCall>
                     <CallAtStop>
                        <StopPointRef>de:08212:3102:12:12</StopPointRef>
                        <StopPointName>
                           <Text>Hagsfeld Bahnhof</Text>
                           <Language>de</Language>
                        </StopPointName>
                        <ServiceArrival>
                           <TimetabledTime> 2021-01-25T03: 06: 00Z </TimetabledTime>
                        </ServiceArrival>
                        <ServiceDeparture>
                           <TimetabledTime>2021-01-25T03:06:00Z</TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber>2</StopSeqNumber>
                     </CallAtStop>
                  </OnwardCall>
                  <OnwardCall>
                     <CallAtStop>
                        <StopPointRef>de:08212:3104:0:2</StopPointRef>
                        <StopPointName>
                           <Text> Hagsfeld Julius-Bender-Straße </Text>
                           <Language>de</Language>
                        </StopPointName>
                        <ServiceArrival>
                           <TimetabledTime>2021-01-25T03:07:00Z</TimetabledTime>
                        </ServiceArrival>
                        <ServiceDeparture>
                           <TimetabledTime>2021-01-25T03:07:00Z</TimetabledTime>
                        </ServiceDeparture>
                        <StopSeqNumber>3</StopSeqNumber>
                     </CallAtStop>
                  </OnwardCall>
                  <Service>
                     <OperatingDayRef>2021-01-25</OperatingDayRef>
                     <JourneyRef>kvv:03094:E:H:j21:24</JourneyRef>
                     <LineRef>kvv:03094:E:H</LineRef>
                     <DirectionRef>outward</DirectionRef>
                     <Mode>
                        <PtMode>bus</PtMode>
                        <BusSubmode>localBus</BusSubmode>
                        <name>
                           <Text>Nightliner</Text>
                           <Language>de</Language>
                        </name>
                     </Mode>
                     <PublishedLineName>
                        <Text> Nightliner NL4 </Text>
                        <Language>de</Language>
                     </PublishedLineName>
                     <OperatorRef>kvv:02</OperatorRef>
                     <RouteDescription>
                        <Text> Hagsfeld - Waldstadt - Marktplatz </Text>
                        <Language>de</Language>
                     </RouteDescription>
                     <Attribute>
                        <Text>
                           <Text> Low-floor wagon </Text>
                           <Language>de</Language>
                        </Text>
                        <Code>126887</Code>
                        <Mandatory>false</Mandatory>
                     </Attribute>
                     <OriginStopPointRef>de:08212:3109:0:2</OriginStopPointRef>
                     <OriginText>
                        <Text> Hagsfeld Storrenacker Süd </Text>
                        <Language> de </Language>
                     </OriginText>
                     <DestinationText>
                        <Text> NL 4 Marketplace </Text>
                        <Language>de</Language>
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
TriasMockClient >> mockForStopEventUnservedLocation [
	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias xmlns="http://www.vdv.de/trias" version="1.1"><ServiceDelivery><ResponseTimestamp xmlns="http://www.siri.org.uk/siri">2021-03-25T16:23:28Z</ResponseTimestamp><ProducerRef xmlns="http://www.siri.org.uk/siri">EFAController10.3.17.15-EFA-REALTIME</ProducerRef><Status xmlns="http://www.siri.org.uk/siri">true</Status><MoreData>false</MoreData><Language>de</Language><DeliveryPayload><StopEventResponse><ErrorMessage><Code>-4030</Code><Text><Text>STOPEVENT_LOCATIONUNSERVED</Text><Language>de</Language></Text></ErrorMessage><StopEventResponseContext><Situations></Situations></StopEventResponseContext></StopEventResponse></DeliveryPayload></ServiceDelivery></Trias>'
]

{ #category : #'private - mocking' }
TriasMockClient >> mockForStopPfizer [

	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias xmlns="http://www.vdv.de/trias" version="1.1"><ServiceDelivery><ResponseTimestamp xmlns="http://www.siri.org.uk/siri">2021-03-15T16:28:11Z</ResponseTimestamp><ProducerRef xmlns="http://www.siri.org.uk/siri">EFAController10.3.17.13-EFA-REALTIME</ProducerRef><Status xmlns="http://www.siri.org.uk/siri">true</Status><MoreData>false</MoreData><Language>de</Language><DeliveryPayload><LocationInformationResponse><Location><Location><StopPoint><StopPointRef>de:08212:3105</StopPointRef><StopPointName><Text>Pfizer</Text><Language>de</Language></StopPointName><LocalityRef>8212000:12</LocalityRef></StopPoint><LocationName><Text>Hagsfeld</Text><Language>de</Language></LocationName><GeoPosition><Longitude>8.45325</Longitude><Latitude>49.02357</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>1</Probability><Mode><PtMode>bus</PtMode><BusSubmode>localBus</BusSubmode></Mode></Location><Location><Location><Address><AddressCode>streetID:1500001302::8212000:-1:Pfizerstraße:Karlsruhe:Pfizerstraße::Pfizerstraße: 76139:ANY:DIVA_STREET:941263:5721286:MRCV:B_W</AddressCode><AddressName><Text>Karlsruhe, Pfizerstraße</Text><Language>de</Language></AddressName><PostalCode> 76139</PostalCode><LocalityName>Karlsruhe</LocalityName><LocalityRef>8212000:-1</LocalityRef><StreetName>Pfizerstraße</StreetName></Address><LocationName><Text>Karlsruhe</Text><Language>de</Language></LocationName><GeoPosition><Longitude>8.45551</Longitude><Latitude>49.02270</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.957000017</Probability></Location><Location><Location><PointOfInterest><PointOfInterestCode>poiID:1000111087:8212000:-1:Karl-Pfizer-Anlage:Karlsruhe:Karl-Pfizer-Anlage:ANY:POI:941473:5720694:MRCV:B_W</PointOfInterestCode><PointOfInterestName><Text>Karlsruhe, Karl-Pfizer-Anlage</Text><Language>de</Language></PointOfInterestName><LocalityRef>8212000:-1</LocalityRef></PointOfInterest><LocationName><Text>Karlsruhe</Text><Language>de</Language></LocationName><GeoPosition><Longitude>8.45740</Longitude><Latitude>49.02619</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.93599999</Probability></Location><Location><Location><Address><AddressCode>streetID:1500000580::8416041:-1:Pfizerstraße:Tübingen:Pfizerstraße::Pfizerstraße: 72070:ANY:DIVA_STREET:1007377:5805650:MRCV:B_W</AddressCode><AddressName><Text>Tübingen, Pfizerstraße</Text><Language>de</Language></AddressName><PostalCode> 72070</PostalCode><LocalityName>Tübingen</LocalityName><LocalityRef>8416041:-1</LocalityRef><StreetName>Pfizerstraße</StreetName></Address><LocationName><Text>Tübingen</Text><Language>de</Language></LocationName><GeoPosition><Longitude>9.04942</Longitude><Latitude>48.52325</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.957000017</Probability></Location><Location><Location><Address><AddressCode>streetID:1500000775::8121000:-1:Pfizerstraße:Heilbronn:Pfizerstraße::Pfizerstraße: 74074:ANY:DIVA_STREET:1027657:5702483:MRCV:B_W</AddressCode><AddressName><Text>Heilbronn, Pfizerstraße</Text><Language>de</Language></AddressName><PostalCode> 74074</PostalCode><LocalityName>Heilbronn</LocalityName><LocalityRef>8121000:-1</LocalityRef><StreetName>Pfizerstraße</StreetName></Address><LocationName><Text>Heilbronn</Text><Language>de</Language></LocationName><GeoPosition><Longitude>9.23160</Longitude><Latitude>49.13334</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.957000017</Probability></Location><Location><Location><Address><AddressCode>streetID:1500002345::8111000:-1:Pfizerstraße:Stuttgart:Pfizerstraße::Pfizerstraße: 70184:ANY:DIVA_STREET:1023053:5763314:MRCV:B_W</AddressCode><AddressName><Text>Stuttgart, Pfizerstraße</Text><Language>de</Language></AddressName><PostalCode> 70184</PostalCode><LocalityName>Stuttgart</LocalityName><LocalityRef>8111000:-1</LocalityRef><StreetName>Pfizerstraße</StreetName></Address><LocationName><Text>Stuttgart</Text><Language>de</Language></LocationName><GeoPosition><Longitude>9.19024</Longitude><Latitude>48.77451</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.957000017</Probability></Location><Location><Location><Address><AddressCode>streetID:1500000800::8415061:-1:Paul-Pfizer-Straße:Reutlingen:Paul-Pfizer-Straße::Paul-Pfizer-Straße: 72762:ANY:DIVA_STREET:1024828:5812270:MRCV:B_W</AddressCode><AddressName><Text>Reutlingen, Paul-Pfizer-Straße</Text><Language>de</Language></AddressName><PostalCode> 72762</PostalCode><LocalityName>Reutlingen</LocalityName><LocalityRef>8415061:-1</LocalityRef><StreetName>Paul-Pfizer-Straße</StreetName></Address><LocationName><Text>Reutlingen</Text><Language>de</Language></LocationName><GeoPosition><Longitude>9.20619</Longitude><Latitude>48.48384</Latitude></GeoPosition></Location><Complete>true</Complete><Probability>0.935000002</Probability></Location></LocationInformationResponse></DeliveryPayload></ServiceDelivery></Trias>'
]

{ #category : #'private - mocking' }
TriasMockClient >> mockForStopRefinementAtLatitude: aLatitude longitude: aLongitude [

	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias xmlns="http://www.vdv.de/trias" version="1.1">
   <ServiceDelivery>
      <ResponseTimestamp xmlns="http://www.siri.org.uk/siri">2021-03-25T13:19:18Z</ResponseTimestamp>
      <ProducerRef xmlns="http://www.siri.org.uk/siri">EFAController10.3.17.15-EFA03</ProducerRef>
      <Status xmlns="http://www.siri.org.uk/siri">true</Status>
      <MoreData>false</MoreData>
      <Language>de</Language>
      <DeliveryPayload>
         <LocationInformationResponse>
            <Location>
               <Location>
                  <StopPoint>
                     <StopPointRef>de:08212:3105</StopPointRef>
                     <StopPointName>
                        <Text>Hagsfeld, Pfizer</Text>
                        <Language>de</Language>
                     </StopPointName>
                     <LocalityRef>8212000:12</LocalityRef>
                  </StopPoint>
                  <LocationName>
                     <Text>Hagsfeld</Text>
                     <Language>de</Language>
                  </LocationName>
                  <GeoPosition>
                     <Longitude>', aLongitude asString ,'</Longitude>
                     <Latitude>', aLatitude asString,'</Latitude>
                  </GeoPosition>
               </Location>
               <Complete>true</Complete>
               <Probability>1</Probability>
            </Location>
         </LocationInformationResponse>
      </DeliveryPayload>
   </ServiceDelivery>
</Trias>'
]

{ #category : #'private - mocking' }
TriasMockClient >> mockForTrip [

	^ '<?xml version="1.0" encoding="UTF-8"?>
<Trias xmlns="http://www.vdv.de/trias" version="1.1">
   <ServiceDelivery>
      <ResponseTimestamp xmlns="http://www.siri.org.uk/siri">2021-03-25T14:45:24Z</ResponseTimestamp>
      <ProducerRef xmlns="http://www.siri.org.uk/siri">EFAController10.3.17.15-EFA01</ProducerRef>
      <Status xmlns="http://www.siri.org.uk/siri">true</Status>
      <MoreData>false</MoreData>
      <Language>de</Language>
      <DeliveryPayload>
         <TripResponse>
            <TripResponseContext>
               <Situations />
            </TripResponseContext>
            <TripResult>
               <ResultId>ID-FDC9B095-0EBE-4EB9-980C-3B036277C3EE</ResultId>
               <Trip>
                  <TripId>ID-990EBA7E-BD40-49EB-B3B2-89AC5A357298</TripId>
                  <Duration>PT38M</Duration>
                  <StartTime>2021-03-25T14:39:00Z</StartTime>
                  <EndTime>2021-03-25T15:17:00Z</EndTime>
                  <Interchanges>0</Interchanges>
                  <Distance>11590</Distance>
                  <TripLeg>
                     <LegId>1</LegId>
                     <TimedLeg>
                        <LegBoard>
                           <StopPointRef>de:08212:18</StopPointRef>
                           <StopPointName>
                              <Text>Durlach, Turmberg (Gleis 1)</Text>
                              <Language>de</Language>
                           </StopPointName>
                           <PlannedBay>
                              <Text>Gleis 1</Text>
                              <Language>de</Language>
                           </PlannedBay>
                           <ServiceDeparture>
                              <TimetabledTime>2021-03-25T14:39:00Z</TimetabledTime>
                              <EstimatedTime>2021-03-25T14:39:00Z</EstimatedTime>
                           </ServiceDeparture>
                           <StopSeqNumber>1</StopSeqNumber>
                        </LegBoard>
                        <LegAlight>
                           <StopPointRef>de:08212:611</StopPointRef>
                           <StopPointName>
                              <Text>Oberreut Badeniaplatz</Text>
                              <Language>de</Language>
                           </StopPointName>
                           <ServiceArrival>
                              <TimetabledTime>2021-03-25T15:17:00Z</TimetabledTime>
                              <EstimatedTime>2021-03-25T15:17:00Z</EstimatedTime>
                           </ServiceArrival>
                           <StopSeqNumber>26</StopSeqNumber>
                        </LegAlight>
                        <Service>
                           <OperatingDayRef>2021-03-25</OperatingDayRef>
                           <JourneyRef>kvv:21001:E:H:j21:252</JourneyRef>
                           <LineRef>kvv:21001:E:H</LineRef>
                           <DirectionRef>outward</DirectionRef>
                           <Mode>
                              <PtMode>tram</PtMode>
                              <TramSubmode>cityTram</TramSubmode>
                              <Name>
                                 <Text>Straßenbahn</Text>
                                 <Language>de</Language>
                              </Name>
                           </Mode>
                           <PublishedLineName>
                              <Text>Straßenbahn 1</Text>
                              <Language>de</Language>
                           </PublishedLineName>
                           <OperatorRef>kvv:02</OperatorRef>
                           <RouteDescription>
                              <Text>Durlach Turmberg - Marktplatz - Europaplatz - Oberreut</Text>
                              <Language>de</Language>
                           </RouteDescription>
                           <Attribute>
                              <Text>
                                 <Text>Niederflurwagen</Text>
                                 <Language>de</Language>
                              </Text>
                              <Code>19492</Code>
                              <Mandatory>false</Mandatory>
                           </Attribute>
                           <OriginText>
                              <Text />
                              <Language>de</Language>
                           </OriginText>
                           <DestinationText>
                              <Text>Oberreut</Text>
                              <Language>de</Language>
                           </DestinationText>
                        </Service>
                        <LegTrack>
                           <TrackSection>
                              <TrackStart>
                                 <StopPointRef>de:08212:18:1:1</StopPointRef>
                                 <LocationName>
                                    <Text>Durlach, Turmberg (Gleis 1)</Text>
                                    <Language>de</Language>
                                 </LocationName>
                              </TrackStart>
                              <TrackEnd>
                                 <StopPointRef>de:08212:611:2:2</StopPointRef>
                                 <LocationName>
                                    <Text>Oberreut Badeniaplatz</Text>
                                    <Language>de</Language>
                                 </LocationName>
                              </TrackEnd>
                              <Projection>
                                 <Position>
                                    <Longitude>8.47851</Longitude>
                                    <Latitude>48.99987</Latitude>
                                 </Position>
                                 <Position>
                                    <Longitude>8.47855</Longitude>
                                    <Latitude>48.99985</Latitude>
                                 </Position>
                                 <Position>
                                    <Longitude>8.47860</Longitude>
                                    <Latitude>48.99983</Latitude>
                                 </Position>
                              </Projection>
                              <Duration>PT38M</Duration>
                              <Length>11590</Length>
                           </TrackSection>
                        </LegTrack>
                     </TimedLeg>
                  </TripLeg>
               </Trip>
               <TripFares>
                  <FromTripLegIdRef>1</FromTripLegIdRef>
                  <ToTripLegIdRef>1</ToTripLegIdRef>
                  <PassedZones>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <FareZone>
                        <FareZoneRef>100</FareZoneRef>
                        <FareZoneText>100</FareZoneText>
                     </FareZone>
                  </PassedZones>
                  <Ticket>
                     <TicketId>2</TicketId>
                     <TicketName>Einzelfahrschein</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>2.600000</Price>
                     <NetPrice>2.430000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                     <ValidityDuration>PT1H30M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>9</TicketId>
                     <TicketName>Einzelfahrschein</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>1.500000</Price>
                     <NetPrice>1.400000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Child</ValidFor>
                     <ValidityDuration>PT1H30M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>16</TicketId>
                     <TicketName>Einzelfahrkarte mit Bahncard (Erwachsene)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>2.000000</Price>
                     <NetPrice>1.870000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                     <ValidityDuration>PT1H30M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>23</TicketId>
                     <TicketName>4er-Karte</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>9.800000</Price>
                     <NetPrice>9.160000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                     <ValidityDuration>PT1H30M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>28</TicketId>
                     <TicketName>4er-Karte</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>4.900000</Price>
                     <NetPrice>4.580000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Child</ValidFor>
                     <ValidityDuration>PT1H30M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>32</TicketId>
                     <TicketName>Tageskarte Citysolo (1 Pers.)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>6.700000</Price>
                     <NetPrice>6.260000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                     <ValidityDuration>PT14H21M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>116</TicketId>
                     <TicketName>Tageskarte Citysolo (1 Kind)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>3.600000</Price>
                     <NetPrice>3.360000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Child</ValidFor>
                     <ValidityDuration>PT14H21M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>34</TicketId>
                     <TicketName>Tageskarte Cityplus (bis 5 Pers.)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>11.200000</Price>
                     <NetPrice>10.470000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidityDuration>PT14H21M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>118</TicketId>
                     <TicketName>Tageskarte Cityplus (bis 5 Kinder)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>6.100000</Price>
                     <NetPrice>5.700000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidityDuration>PT14H21M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>36</TicketId>
                     <TicketName>Tageskarte City quattro (1 Pers.)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>24.000000</Price>
                     <NetPrice>22.430000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                     <ValidityDuration>PT14H21M</ValidityDuration>
                  </Ticket>
                  <Ticket>
                     <TicketId>38</TicketId>
                     <TicketName>9-Uhr-Karte</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>54.000000</Price>
                     <NetPrice>50.470000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>40</TicketId>
                     <TicketName>übertragbare Monatskarte (Monat)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>66.000000</Price>
                     <NetPrice>61.680000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>46</TicketId>
                     <TicketName>übertragbare Jahreskarte (Jahr)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>684.000000</Price>
                     <NetPrice>639.250000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>52</TicketId>
                     <TicketName>personalisierte Jahreskarte (AboFix)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>57.000000</Price>
                     <NetPrice>53.270000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Adult</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>58</TicketId>
                     <TicketName>Ausbildung Monatskarte</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>49.500000</Price>
                     <NetPrice>46.260000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                  </Ticket>
                  <Ticket>
                     <TicketId>100</TicketId>
                     <TicketName>Karte ab 65 (Monat)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>48.000000</Price>
                     <NetPrice>44.860000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Senior</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>101</TicketId>
                     <TicketName>Karte ab 65 (Jahr)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>576.000000</Price>
                     <NetPrice>538.320000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Senior</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>93</TicketId>
                     <TicketName>KombiCard (Monat)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>91.000000</Price>
                     <NetPrice>85.050000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Senior</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>94</TicketId>
                     <TicketName>KombiCard (Jahr)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>1092.000000</Price>
                     <NetPrice>1020.560000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Senior</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>95</TicketId>
                     <TicketName>KombiCard-Partnerkarte (Monat)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>68.250000</Price>
                     <NetPrice>63.790000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Senior</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>96</TicketId>
                     <TicketName>KombiCard-Partnerkarte (Jahr)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>819.000000</Price>
                     <NetPrice>765.420000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                     <ValidFor>Senior</ValidFor>
                  </Ticket>
                  <Ticket>
                     <TicketId>97</TicketId>
                     <TicketName>Studikarte (Semester)</TicketName>
                     <FaresAuthorityRef>kvv</FaresAuthorityRef>
                     <FaresAuthorityText>KVV</FaresAuthorityText>
                     <Price>162.800000</Price>
                     <NetPrice>152.150000</NetPrice>
                     <Currency>EUR</Currency>
                     <VatRate>half</VatRate>
                     <TravelClass>second</TravelClass>
                  </Ticket>
               </TripFares>
            </TripResult>
         </TripResponse>
      </DeliveryPayload>
   </ServiceDelivery>
</Trias>'
]

{ #category : #requesting }
TriasMockClient >> mockResponsesAt: aTemplateString [
	
	^ mockResponses at: aTemplateString ifAbsentPut: [WaitfreeQueue new]
]

{ #category : #'private - mock installing' }
TriasMockClient >> resetMockStopEvent [
	
	self  resetResponseForRequest: #templateEventsRequestWithOnwardDepartures.
]

{ #category : #'private - mock installing' }
TriasMockClient >> resetResponseForRequest: aRequestTemplateAccessor [ 
	(mockResponses at: (self perform: aRequestTemplateAccessor) put: (WaitfreeQueue new)) .
]
