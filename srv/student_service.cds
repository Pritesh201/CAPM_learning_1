using {student.db as model} from '../db/schema';
using {API_BUSINESS_PARTNER as external} from './external/API_BUSINESS_PARTNER';
using {employeeset as onprem} from './external/employeeset';

// @impl: 'srv/student_service.cjs'
service StudentAPIService {

    entity StudentSet as projection on model.Students;
    
    entity Authors as projection on model.Authors;

    entity Status as projection on model.Status;

    entity Products as projection on model.Products;

    @odata.draft.enabled //to enable the draft feature for CAPM
    entity Customer as projection on model.Customer
    actions{
        action updateCustomer() returns String;
    };

    entity Orders as projection on model.Orders;

    entity ITEmployee as select ID, name from model.Employee where deptid.departmentID = 'IT';

    // custom Unbound action
    action updateCustomerStatus(customerID: String, name: String) returns String;

    entity A_BusinessPartner as projection on external.A_BusinessPartner;

    entity EmployeeSet as projection on onprem.EmployeeSet;

}
