%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo({
  "SupplierId": 300000002336641,
  "SupplierPartyId": 300000002336642,
  "Supplier": "INT Supplier with Address Updated",
  "SupplierNumber": "10005",
  "AlternateName": null,
  "TaxOrganizationTypeCode": "CORPORATION",
  "TaxOrganizationType": "Corporation",
  "SupplierTypeCode": null,
  "SupplierType": null,
  "InactiveDate": null,
  "Status": "ACTIVE",
  "BusinessRelationshipCode": "SPEND_AUTHORIZED",
  "BusinessRelationship": "Spend Authorized",
  "ParentSupplierId": null,
  "ParentSupplier": null,
  "ParentSupplierNumber": null,
  "CreationDate": "2023-08-16T09:51:46.001+00:00",
  "CreatedBy": "INTUSER",
  "LastUpdateDate": "2023-08-21T17:21:01.026+00:00",
  "LastUpdatedBy": "INTUSER",
  "CreationSourceCode": "WEB_SERVICE",
  "CreationSource": "Web Service",
  "DataFoxScore": null,
  "DataFoxScoringCriteria": null,
  "Alias": null,
  "DUNSNumber": "016082023",
  "OneTimeSupplierFlag": false,
  "RegistryId": "2011",
  "CustomerNumber": null,
  "StandardIndustryClass": null,
  "IndustryCategory": null,
  "IndustrySubcategory": null,
  "NationalInsuranceNumber": null,
  "NationalInsuranceNumberExistsFlag": false,
  "CorporateWebsite": null,
  "YearEstablished": null,
  "MissionStatement": null,
  "YearIncorporated": null,
  "ChiefExecutiveTitle": null,
  "ChiefExecutiveName": null,
  "PrincipalTitle": null,
  "PrincipalName": null,
  "FiscalYearEndMonthCode": null,
  "FiscalYearEndMonth": null,
  "CurrentFiscalYearPotentialRevenue": null,
  "PreferredFunctionalCurrencyCode": null,
  "PreferredFunctionalCurrency": null,
  "TaxRegistrationCountryCode": null,
  "TaxRegistrationCountry": null,
  "TaxRegistrationNumber": null,
  "TaxpayerCountryCode": "US",
  "TaxpayerCountry": "United States",
  "TaxpayerId": "0016082023",
  "TaxpayerIdExistsFlag": true,
  "FederalReportableFlag": false,
  "FederalIncomeTaxTypeCode": null,
  "FederalIncomeTaxType": null,
  "StateReportableFlag": false,
  "TaxReportingName": null,
  "NameControl": null,
  "VerificationDate": null,
  "UseWithholdingTaxFlag": false,
  "WithholdingTaxGroupId": null,
  "WithholdingTaxGroup": null,
  "BusinessClassificationNotApplicableFlag": false,
  "DataFoxId": null,
  "DataFoxCompanyName": null,
  "DataFoxLegalName": null,
  "DataFoxCompanyPrimaryURL": null,
  "DataFoxNAICSCode": null,
  "DataFoxCountry": null,
  "DataFoxEIN": null,
  "DataFoxLastSyncDate": null,
  "OBNEnabledFlag": null,
  "OnOFACListFlag": null,
  "OFACSources": null,
  "addresses": [
    {
      "SupplierAddressId": 300000002336645,
      "AddressName": "Headquarter",
      "CountryCode": "US",
      "Country": "United States",
      "AddressLine1": "Example Road updated",
      "AddressLine2": null,
      "AddressLine3": null,
      "AddressLine4": null,
      "City": "Redwood City",
      "State": "CA",
      "PostalCode": "94065",
      "PostalCodeExtension": null,
      "Province": null,
      "County": null,
      "Building": null,
      "FloorNumber": null,
      "PhoneticAddress": null,
      "LanguageCode": null,
      "Language": null,
      "Addressee": null,
      "GlobalLocationNumber": null,
      "AdditionalAddressAttribute1": null,
      "AdditionalAddressAttribute2": null,
      "AdditionalAddressAttribute3": null,
      "AdditionalAddressAttribute4": null,
      "AdditionalAddressAttribute5": null,
      "AddressPurposeOrderingFlag": true,
      "AddressPurposeRemitToFlag": true,
      "AddressPurposeRFQOrBiddingFlag": false,
      "PhoneCountryCode": null,
      "PhoneAreaCode": null,
      "PhoneNumber": null,
      "PhoneExtension": null,
      "FaxCountryCode": null,
      "FaxAreaCode": null,
      "FaxNumber": null,
      "Email": null,
      "InactiveDate": "4712-12-31",
      "Status": "ACTIVE",
      "CreationDate": "2023-08-16T09:51:46.165+00:00",
      "CreatedBy": "INTUSER",
      "LastUpdateDate": "2023-08-21T17:21:01.644+00:00",
      "LastUpdatedBy": "INTUSER",
      "links": [
        {
          "rel": "self",
          "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/addresses/300000002336645",
          "name": "addresses",
          "kind": "item",
          "properties": {
            "changeIndicator": "ACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000008770400000008737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000027371007E0002000000027371007E0002000000017371007E0002000000017372001B6F7261636C652E6A626F2E646F6D61696E2E4E756C6C56616C75655899C1C58DAABEEB02000149000A6D53514C54797065496478700000000C71007E000971007E000971007E000978"
          }
        },
        {
          "rel": "canonical",
          "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/addresses/300000002336645",
          "name": "addresses",
          "kind": "item"
        },
        {
          "rel": "parent",
          "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641",
          "name": "suppliers",
          "kind": "item"
        },
        {
          "rel": "lov",
          "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/addresses/300000002336645/lov/CountryLookup",
          "name": "CountryLookup",
          "kind": "collection"
        },
        {
          "rel": "lov",
          "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/addresses/300000002336645/lov/LanguageLookup",
          "name": "LanguageLookup",
          "kind": "collection"
        },
        {
          "rel": "child",
          "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/addresses/300000002336645/child/DFF",
          "name": "DFF",
          "kind": "collection"
        }
      ]
    }
  ],
  "links": [
    {
      "rel": "self",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641",
      "name": "suppliers",
      "kind": "item",
      "properties": {
        "changeIndicator": "ACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000007770400000007737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000027371007E0002000000037372001B6F7261636C652E6A626F2E646F6D61696E2E4E756C6C56616C75655899C1C58DAABEEB02000149000A6D53514C54797065496478700000000C7371007E00020000000271007E00077371007E00020000000171007E000778"
      }
    },
    {
      "rel": "canonical",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641",
      "name": "suppliers",
      "kind": "item"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/CountryLookup",
      "name": "CountryLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/FiscalYearEndMonthLookup",
      "name": "FiscalYearEndMonthLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/ParentSupplierLookup",
      "name": "ParentSupplierLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/CurrencyLookup",
      "name": "CurrencyLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/BusinessRelationshipLookup",
      "name": "BusinessRelationshipLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/TaxOrganizationTypeLookup",
      "name": "TaxOrganizationTypeLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/SupplierTypeLookup",
      "name": "SupplierTypeLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/FederalIncomeTaxTypeLookup",
      "name": "FederalIncomeTaxTypeLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/lov/WithholdingTaxGroupLookup",
      "name": "WithholdingTaxGroupLookup",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/DFF",
      "name": "DFF",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/addresses",
      "name": "addresses",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/attachments",
      "name": "attachments",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/businessClassifications",
      "name": "businessClassifications",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/contacts",
      "name": "contacts",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/globalDFF",
      "name": "globalDFF",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/productsAndServices",
      "name": "productsAndServices",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/child/sites",
      "name": "sites",
      "kind": "collection"
    },
    {
      "rel": "action",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/action/scores",
      "name": "scores",
      "kind": "other"
    },
    {
      "rel": "action",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/action/signals",
      "name": "signals",
      "kind": "other"
    },
    {
      "rel": "action",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000002336641/action/submitSpendAuthorizationRequest",
      "name": "submitSpendAuthorizationRequest",
      "kind": "other"
    }
  ]
})