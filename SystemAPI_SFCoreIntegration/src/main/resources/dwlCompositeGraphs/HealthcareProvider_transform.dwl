%dw 2.0
output application/json skipNullOn="everywhere"

fun yNTransform (val) = if(val == 'Yes') 'true' else if (val == 'No') 'false' else null
//fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]

---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  ( if (!isEmpty(item.AccountId))   
	 [{
      "url" : (item.Account.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
      "method": "GET",
      "referenceId": 'Account_' ++ index
   }] else   [])

++
  
  [{
      "url" : (item.attributes.url) replace '/HealthcareProvider/' with '/HealthcareProvider/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'HCProvider_' ++ index,
      "body" : {
        
        ("Account": {"External_Id__c": item.AccountId }) if (!isEmpty(item.AccountId)),
        //("AccountId": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.AccountId)),
        ("Practitioner": {"External_Id__c": item.PractitionerId}) if (!isEmpty(item.PractitionerId)),
        //("PractitionerId": "@{Account_" ++ index ++ '.PersonContactId}') if (!isEmpty("@{Account_" ++ index ++ '.PersonContactId}') and !isEmpty(item.AccountId)),		
        ("ReferredByContact": {"External_Id__c": item.ReferredByContactId}) if (!isEmpty(item.ReferredByContactId)),

        "EffectiveTo": item.EffectiveTo,
        "IsNotSearchable": item.IsNotSearchable,
        "TotalLicensedBeds": item.TotalLicensedBeds,
        "Status": item.Status,
        "TerminationReason": item.TerminationReason,
        "InitialStartDate": item.InitialStartDate,
        "SourceSystemIdentifier": item.SourceSystemIdentifier,
        "EffectiveFrom": item.EffectiveFrom,
        "ProviderClass": item.ProviderClass,
        "Name": item.Name,
        "CaqhIdentifier": item.CaqhIdentifier,
        "HasCarrierContract": item.HasCarrierContract,
        "ProviderType": item.ProviderType,
        "TerminationDate": item.TerminationDate,
        "SourceSystem": item.SourceSystem,
        "Monday__c": item.Monday__c,
        "Tuesday__c": item.Tuesday__c,
        "Wednesday__c": item.Wednesday__c,
        "Thursday__c": item.Thursday__c,
        "Friday__c": item.Friday__c,
        "Saturday__c": item.Saturday__c,
        "Sunday__c": item.Sunday__c,
        "Scheduling_Comments__c": item.Scheduling_Comments__c,

        "Able_to_perform_muscle_strength_testing__c": item.Individual_Application__r.Able_to_perform_muscle_strength_testing__c,
        "Additional_Supplies__c": item.Individual_Application__r.Additional_Supplies__c,
        "Additional_Traveling_Comments__c": item.Individual_Application__r.Additional_Traveling_Comments__c,

        "Are_you_a_veteran_of_the_US_Armed_Forces__c": yNTransform(item.Individual_Application__r.Are_you_a_veteran_of_the_US_Armed_Forces__c),
        "Are_you_able_to_travel_out_of_state__c": yNTransform(item.Individual_Application__r.Are_you_able_to_travel_out_of_state__c),
        "Are_you_available_for_block_scheduling__c": yNTransform(item.Individual_Application__r.Are_you_available_for_block_scheduling__c),
        "are_you_willing_to_travel_out_of__c": yNTransform(item.Individual_Application__r.are_you_willing_to_travel_out_of__c),
        
        "Blood_Pressure_Cuff_Sphygmomanometer__c": item.Individual_Application__r.Blood_Pressure_Cuff_Sphygmomanometer__c,
        
        "Can_conduct_exams_outside_your_country__c": yNTransform(item.Individual_Application__r.Can_conduct_exams_outside_your_country__c),
        "Can_you_conduct_visual_field_testing__c": yNTransform(item.Individual_Application__r.Can_you_conduct_visual_field_testing__c),
        "Can_you_do_panoramic_or_bite_wing_Xrays__c": yNTransform(item.Individual_Application__r.Can_you_do_panoramic_or_bite_wing_Xrays__c),
        "Can_you_perform_acoustic_reflex_testing__c": yNTransform(item.Individual_Application__r.Can_you_perform_acoustic_reflex_testing__c),
        "Can_you_perform_an_audiogram__c": yNTransform(item.Individual_Application__r.Can_you_perform_an_audiogram__c),
        "Can_you_perform_Neurological_Testing__c": yNTransform(item.Individual_Application__r.Can_you_perform_Neurological_Testing__c),
        "Can_you_perform_pelvic_exams__c": yNTransform(item.Individual_Application__r.Can_you_perform_pelvic_exams__c),
        "Can_you_perform_psychological_testing__c": yNTransform(item.Individual_Application__r.Can_you_perform_psychological_testing__c),
        "Can_you_perform_rectal_exams__c": yNTransform(item.Individual_Application__r.Can_you_perform_rectal_exams__c),
        "Can_you_perform_speech_discrimination_te__c": yNTransform(item.Individual_Application__r.Can_you_perform_speech_discrimination_te__c),
        "Can_you_perform_Stenger_testing__c": yNTransform(item.Individual_Application__r.Can_you_perform_Stenger_testing__c),


        "Disabled_Veteran_Owned_Business__c": item.Individual_Application__r.Disabled_Veteran_Owned_Business__c,
        "Disadvantaged_Business__c": item.Individual_Application__r.Disadvantaged_Business__c,

        "Do_you_have_a_goniometer__c": yNTransform(item.Individual_Application__r.Do_you_have_a_goniometer__c),
        "Does_audio_booth_accommodate_wheelchair__c": yNTransform(item.Individual_Application__r.Does_audio_booth_accommodate_wheelchair__c),
        "Does_your_audio_booth_meet_ANSI_standard__c": yNTransform(item.Individual_Application__r.Does_your_audio_booth_meet_ANSI_standard__c),

        "Ear_Speculums_disposable__c": item.Individual_Application__r.Ear_Speculums_disposable__c,
        "Exam_Shorts__c": item.Individual_Application__r.Exam_Shorts__c,
        "Eye_Occluder__c": item.Individual_Application__r.Eye_Occluder__c,
        "Goniometer_Set__c": item.Individual_Application__r.Goniometer_Set__c,
        "How_far_are_you_able_to_travel__c": item.Individual_Application__r.How_far_are_you_able_to_travel__c,
        "How_often_are_you_able_to_travel__c": item.Individual_Application__r.How_often_are_you_able_to_travel__c,
        "HUB_Zone_Business__c": item.Individual_Application__r.HUB_Zone_Business__c,
        
        "Interested_Available_to_travel_for_exams__c": yNTransform(item.Individual_Application__r.Interested_Available_to_travel_for_exams__c),
        "Is_your_audio_booth_completely_enclosed__c": yNTransform(item.Individual_Application__r.Is_your_audio_booth_completely_enclosed__c),
        "Is_your_audio_booth_sound_proof__c": yNTransform(item.Individual_Application__r.Is_your_audio_booth_sound_proof__c),
        
        "Knee_Reflex__c": item.Individual_Application__r.Knee_Reflex__c,
        "Nitrile_Exam_Gloves__c": item.Individual_Application__r.Nitrile_Exam_Gloves__c,

        "Only_within_my_country__c": yNTransform(item.Individual_Application__r.Only_within_my_country__c),

        "Ophthalmoscope__c": item.Individual_Application__r.Ophthalmoscope__c,
        "Otoscope__c": item.Individual_Application__r.Otoscope__c,
        "Pinwheel__c": item.Individual_Application__r.Pinwheel__c,
        "Plastic_Vaginal_Specula__c": item.Individual_Application__r.Plastic_Vaginal_Specula__c,
        "Small_Business__c": item.Individual_Application__r.Small_Business__c,
        "Snellen_Chart__c": item.Individual_Application__r.Snellen_Chart__c,
        "Stethoscope__c": item.Individual_Application__r.Stethoscope__c,
        "Tissue_Gowns__c": item.Individual_Application__r.Tissue_Gowns__c,
        "Tongue_Depressors__c": item.Individual_Application__r.Tongue_Depressors__c,
        "Tuning_Fork__c": item.Individual_Application__r.Tuning_Fork__c,
        "VAMC_Experience__c": item.Individual_Application__r.VAMC_Experience__c,
        "Veteran_Owned_Business__c": item.Individual_Application__r.Veteran_Owned_Business__c,
        "What_is_your_Doxy_Link__c": item.Individual_Application__r.What_is_your_Doxy_Link__c,

        "Willing_to_participate_in_Tele_C_P__c": yNTransform(item.Individual_Application__r.Willing_to_participate_in_Tele_C_P__c),
        
        "Woman_Owned_Business__c": item.Individual_Application__r.Woman_Owned_Business__c,
        "Contracting_to_Perform_Diagnostics__c" : item.Contracting_to_Perform_Diagnostics__c,
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
        
      }
  }]
      
})}