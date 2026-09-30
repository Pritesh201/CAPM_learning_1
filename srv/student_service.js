const { update } = require("@sap/cds");
const { message } = require("@sap/cds/lib/log/cds-error");
const { UPDATE } = require("@sap/cds/lib/ql/cds-ql");
const { tar } = require("@sap/cds/lib/utils/cds-utils");

class StudentAPIService extends cds.ApplicationService {
    async init() {
        const externalService = await cds.connect.to('API_BUSINESS_PARTNER');
        const onpremService = await cds.connect.to('employeeset');
        const { Customer, Orders, A_BusinessPartner, EmployeeSet } = this.entities;

        this.before('UPDATE', Customer.drafts, (req) => {
            // debugger;

            const { email } = req.data;

            if (email) {
                const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

                const isValid = regex.test(email);

                if (!isValid) {

                    return req.reject({
                        status: 400,
                        message: "Invalid Email Address!",
                        target: "email"
                    });
                }


            }


        })

        this.before('CREATE', Orders.drafts, async(req)=>{
            req.data.orderDate = new Date().toISOString().split('T')[0];
            return req;
        })

        this.on("updateCustomerStatus", async(req)=>{
            const {customerID, name} = req.data;

            if(customerID){
                let customerData = await SELECT.from(Customer).where({
                    "customerID": customerID
                })

                if(!customerData){
                    return req.reject(404,"Customer Record Not Found!");
                }

                await UPDATE(Customer).set({
                    status_id: 1
                }).where({
                    "customerID":customerID
                })

                return "Status has been updated successfully."
            }
        });

        this.on("updateCustomer", async(req)=>{
            const {customerID} =req.params[0];

            if(customerID){
                await UPDATE(Customer).set({
                    status_id: 2
                }).where({
                    "customerID":customerID
                })
            }
            return;
        });

        this.on('READ',A_BusinessPartner, async(req)=>{

            return await externalService.run(req.query);

        });

        this.on('READ',EmployeeSet, async(req)=>{

            return await onpremService.run(req.query);

        });

        return super.init()

        
    }
}

module.exports = StudentAPIService