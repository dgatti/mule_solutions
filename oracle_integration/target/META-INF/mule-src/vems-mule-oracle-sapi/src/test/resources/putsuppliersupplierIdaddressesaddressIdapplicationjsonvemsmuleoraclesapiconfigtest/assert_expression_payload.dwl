%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo({
  "SupplierAddressId": 300000002336616,
  "AddressName": "Headquarter",
  "CountryCode": "US",
  "Country": "United States",
  "AddressLine1": "Example New Road",
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
  "CreationDate": "2023-08-07T07:39:10.027+00:00",
  "CreatedBy": "INTUSER",
  "LastUpdateDate": "2023-08-07T07:42:06.138+00:00",
  "LastUpdatedBy": "INTUSER",
  "links": [
    {
      "rel": "self",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000001964004/child/addresses/300000002336616",
      "name": "addresses",
      "kind": "item",
      "properties": {
        "changeIndicator": "ACED0005737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000008770400000008737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000027371007E0002000000027371007E0002000000027371007E0002000000027372001B6F7261636C652E6A626F2E646F6D61696E2E4E756C6C56616C75655899C1C58DAABEEB02000149000A6D53514C54797065496478700000000C71007E000971007E000971007E000978"
      }
    },
    {
      "rel": "canonical",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000001964004/child/addresses/300000002336616",
      "name": "addresses",
      "kind": "item"
    },
    {
      "rel": "parent",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000001964004",
      "name": "suppliers",
      "kind": "item"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000001964004/child/addresses/300000002336616/lov/CountryLookup",
      "name": "CountryLookup",
      "kind": "collection"
    },
    {
      "rel": "lov",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000001964004/child/addresses/300000002336616/lov/LanguageLookup",
      "name": "LanguageLookup",
      "kind": "collection"
    },
    {
      "rel": "child",
      "href": "https://ibnajb-test.fa.ocs.oraclecloud.com:443/fscmRestApi/resources/11.13.18.05/suppliers/300000001964004/child/addresses/300000002336616/child/DFF",
      "name": "DFF",
      "kind": "collection"
    }
  ]
})