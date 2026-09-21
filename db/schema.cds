namespace student.db;

using {
    cuid,
    managed
} from '@sap/cds/common';

type nameType: String(50);

entity Students : cuid, managed {
    //key student_id : UUID;
    name    : nameType;
    address : String;
    email   : nameType;
    mobile  : String;
    age     : Integer;
    gender  : String;

}

entity Courses : cuid, managed {
    //key courseID : UUID;
    name     : String;
    cost     : Decimal(10, 2);
    trainer  : String;
    duration : Integer;

}
