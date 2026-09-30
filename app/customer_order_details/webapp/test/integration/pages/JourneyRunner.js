sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/customer/app/customerorderdetails/test/integration/pages/CustomerList.gen",
	"com/customer/app/customerorderdetails/test/integration/pages/CustomerObjectPage.gen"
], function (JourneyRunner, CustomerListGenerated, CustomerObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/customer/app/customerorderdetails') + '/test/flp.html#app-preview',
        pages: {
			onTheCustomerListGenerated: CustomerListGenerated,
			onTheCustomerObjectPageGenerated: CustomerObjectPageGenerated
        },
        async: true
    });

    return runner;
});

