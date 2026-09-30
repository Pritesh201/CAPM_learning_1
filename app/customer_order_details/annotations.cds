using StudentAPIService as service from '../../srv/student_service';
using from '@sap/cds/common';
using from '../../db/schema';

annotate service.Customer with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Customer',
            ID : 'Customer',
            Target : '@UI.FieldGroup#Customer',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Orders',
            ID : 'Orders',
            Target : 'orderNo/@UI.LineItem#Orders',
        },
    ],
    UI.FieldGroup #Customer : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : customerID,
                Label : 'customerID',
            },
            {
                $Type : 'UI.DataField',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Value : mobile,
            },
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : address,
            },
            {
                $Type : 'UI.DataField',
                Value : country_code,
            },
            {
                $Type : 'UI.DataField',
                Value : status.name,
                Label : 'Status',
                Criticality : status.criticality,
            },
            {
                $Type : 'UI.DataField',
                Value : product_productID,
                Label : 'Products',
            },
            {
                $Type : 'UI.DataField',
                Value : product.name,
                Label : 'Product Name',
            },
            {
                $Type : 'UI.DataField',
                Value : product.description,
                Label : 'Description',
            },
            {
                $Type : 'UI.DataField',
                Value : product.category,
                Label : 'Category',
            },
            {
                $Type : 'UI.DataField',
                Value : product.price,
                Label : 'Price',
            },
            {
                $Type : 'UI.DataField',
                Value : product.stock,
                Label : 'Stock',
            },
        ],
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : address,
        },
        {
            $Type : 'UI.DataField',
            Value : country_code,
        },
        {
            $Type : 'UI.DataField',
            Value : customerID,
            Label : 'customerID',
        },
        {
            $Type : 'UI.DataField',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Value : mobile,
        },
        {
            $Type : 'UI.DataField',
            Value : name,
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
    UI.LineItem #tableView : [
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View 1',
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'StudentAPIService.updateCustomer',
            Label : 'Deactivate',
            Criticality : #Negative,
        },
    ],
);

annotate service.Orders with @(
    UI.LineItem #Orders : [
        {
            $Type : 'UI.DataField',
            Value : orderDate,
            Label : 'orderDate',
        },
        {
            $Type : 'UI.DataField',
            Value : orderID,
            Label : 'orderID',
        },
    ]
);

annotate service.Customer with {
    product @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : product_productID,
                    ValueListProperty : 'productID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'price',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'category',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'stock',
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.Products with {
    productID @Common.Text : name
};

annotate service.Customer with @(
    Common.SideEffects:{
        SourceProperties:[
            'product_productID'
        ],
        TargetProperties:[
            'product/category',
            'product/name',
            'product/description',
            'product/price',
            'product/stock'

        ]
    }
);

