namespace student.db;

using {
    cuid,
    managed,
    Country
} from '@sap/cds/common';

type nameType : String(50);

type Country2 : Association to Country1;

entity Country1 {
    key code  : String;
    key name  : String;
        descr : String
}

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

entity Address {
    key addressID   : Integer;
        description : String;
        city        : String;
        country     : String;
        pincode     : Integer;

}

entity Books : cuid {

    name          : String;
    title         : String;
    publishedDate : String;
    author        : Association to Authors; //managed association

}


entity Authors : cuid {

    name  : String;
    books : Composition of many Books
                on books.author = $self;

}

entity Employee : cuid {
    name    : String(50);
    address : String(200);
    email   : String(50);
    deptid  : Association to Departments;
}

entity Departments {
    key departmentID : Integer;
        name         : String(50);

}

entity Orders {
    key orderID    : UUID;
        orderDate  : Date;
        customer   : Association to Customer;
        orderItems : Composition of many OrderItems
                         on orderItems.orderNo = $self;

}

entity OrderItems {
    key orderItemID       : UUID;
        orderItemName     : String;
        orderItemPrice    : Integer;
        orderItemQuantity : Integer;
        orderNo           : Association to Orders;
}

entity Customer {
    key customerID : UUID;
        name       : String(50) @title: '{i18n>name}';
        address    : String     @title: '{i18n>Address}';
        email      : String     @title: '{i18n>Email}';
        mobile     : String     @title: '{i18n>Mobile}';
        orderNo    : Composition of many Orders
                         on orderNo.customer = $self;
        country    : Country;
        status     : Association to Status;
        product    : Association to Products;

}

entity Status {
    key id          : Integer;
        name        : String;
        criticality : Integer;

}

entity Products {
    key productID   : Integer;
        name        : String;
        price       : Decimal(10, 2);
        category    : String;
        description : String;
        stock       : Integer;

}
