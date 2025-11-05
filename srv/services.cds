using { my.incidents as my } from '../db/schema';

service ProcessorService {
    entity Incidents as projection on my.Incidents;
    @readonly entity Customers as projection on my.Customers;
}

service AdminService {
    entity Customers as projection on my.Customers;
    entity Incidents as projection on my.Incidents;
}


annotate ProcessorService.Incidents with @odata.draft.enabled;

// <--- restrictions --->
annotate ProcessorService with @(requires: 'support');
annotate AdminService with @(requires: 'admin');


annotate ProcessorService.Incidents with @changelog: {
  keys: [ customer.name, createdAt ]
} {
  title    @changelog;
  status   @changelog;
  customer @changelog: [ customer.name ];
};

annotate ProcessorService.Incidents.conversation with @changelog: {
  keys: [ author, timestamp ]
} {
  message  @changelog;
}