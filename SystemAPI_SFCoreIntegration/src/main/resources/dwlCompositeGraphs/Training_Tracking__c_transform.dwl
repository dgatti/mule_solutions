%dw 2.0
output application/json skipNullOn="everywhere"

fun coreRecTypeId(rtId,rtObj) = (vars.coreRT filter ($.DeveloperName == ((vars.pnmRT filter ($.Id == rtId and $.SobjectType == rtObj)).DeveloperName[0]) and $.SobjectType == rtObj)).Id[0]


---
{ graphs: (
      
      payload map (item, index) -> {
    
  "graphId": index,
  "compositeRequest": 
  
  ( if (!isEmpty(item.Account__c))   
	 [{
      "url" : (item.Account__r.attributes.url) replace '/Account/' with '/Account/External_Id__c/',
      "method": "GET",
      "referenceId": 'Account_' ++ index
   }] else   [])

++
  
  [{
     
      "url" : (item.attributes.url) replace '/Training_Tracking__c/' with '/Training_Tracking__c/External_Id__c/' ,
      "method": "PATCH",
      "referenceId": 'TrainTrack_' ++ index,
      "body" : {
      	("Account__c": "@{Account_" ++ index ++ '.Id}') if (!isEmpty(item.Account__c)),
        "Aggravation_Opinions__c": item.Aggravation_Opinions__c,
        "Aggravation_Opinions_Cert_Attached__c": item.Aggravation_Opinions_Cert_Attached__c,
        
        
        
        "Camp_Lejeune_Cert_Attached__c": item.Camp_Lejeune_Cert_Attached__c,
        "Camp_Lejeune_Contaminated_Water_CLCW__c": item.Camp_Lejeune_Contaminated_Water_CLCW__c,
        
        "General_Certification_Attached__c": item.General_Certification_Attached__c,
        "Gulf_War_General_Medical_Exam__c": item.Gulf_War_General_Medical_Exam__c,
        "General_Certification_Overview__c": item.General_Certification_Overview__c,
        
        "Gulf_War_General_Cert_Attached__c": item.Gulf_War_General_Cert_Attached__c,
        "Last_Appointment_Date__c": item.Last_Appointment_Date__c,
        "Lethal_Means_Safety__c": item.Lethal_Means_Safety__c,
        
        "Lethal_Means_Safety_Cert_Attached__c": item.Lethal_Means_Safety_Cert_Attached__c,
        "Medical_Opinions__c": item.Medical_Opinions__c,
        
        "Medical_Opinions_Cert_Attached__c": item.Medical_Opinions_Cert_Attached__c,
        
        "Mental_Health_Cert_Attached__c": item.Mental_Health_Cert_Attached__c,
        "Mental_Health_Certification_Course__c": item.Mental_Health_Certification_Course__c,

        "Military_Culture_and_Vets_Cert_Attached__c": item.Military_Culture_and_Vets_Cert_Attached__c,

        "Military_Sexual_Trauma_and_the_Disabilit__c": item.Military_Sexual_Trauma_and_the_Disabilit__c,
        
        "Military_Sexual_Trauma_Cert_Attached__c": item.Military_Sexual_Trauma_Cert_Attached__c,
        
        "Musculoskeletal_Exam_Cert_Attached__c": item.Musculoskeletal_Exam_Cert_Attached__c,

        "Musculoskeletal_Examination__c": item.Musculoskeletal_Examination__c,
        
        "PACT_Act_Cert_Attached__c": item.PACT_Act_Cert_Attached__c,
        "RecordTypeId": coreRecTypeId(item.RecordTypeId, 'Training_Tracking__c'),
        "PACT_Act_Key_Terms_Medical_Opinions_f__c": item.PACT_Act_Key_Terms_Medical_Opinions_f__c,
        
        "Separation_Health_Asses_Cert_Attached__c": item.Separation_Health_Asses_Cert_Attached__c,
        "Separation_Health_Assessment_SHA_DD314__c": item.Separation_Health_Assessment_SHA_DD314__c,
        
        "specialtyToFieldMap__c": item.specialtyToFieldMap__c,
        
        "Spina_Bifida_Certification_Attached__c": item.Spina_Bifida_Certification_Attached__c,
        "Spina_Bifida_Examinations__c": item.Spina_Bifida_Examinations__c,
        "Name": item.Name,
        "Suicide_Awareness_and_Prevention__c": item.Suicide_Awareness_and_Prevention__c,
        "Suicide_Awareness_Cert_Attached__c": item.Suicide_Awareness_Cert_Attached__c,
        
        "TBI_Examination_Cert_Attached__c": item.TBI_Examination_Cert_Attached__c,
       "The_Veteran_Experience__c": item.The_Veteran_Experience__c,
        "Traumatic_Brain_Injury_TBI_Examination__c": item.Traumatic_Brain_Injury_TBI_Examination__c,
        "Understanding_Military_Culture_and_Veter__c": item.Understanding_Military_Culture_and_Veter__c, 
        "Value__c": item.Value__c,
       
       
        "VES_Big_Four_Training_Required__c": item.VES_Big_Four_Training_Required__c,
        "VES_Gen_Med_Required_Training__c": item.VES_Gen_Med_Required_Training__c,
        "VES_General_Courses_Required__c": item.VES_General_Courses_Required__c,
        "VES_General_Courses_Status__c": item.VES_General_Courses_Status__c,
        "IMO_Training_Required__c": item.IMO_Training_Required__c,
        "VES_Psych_Training_Required__c": item.VES_Psych_Training_Required__c,
        
        "Veteran_Experience_Cert_Attached__c": item.Veteran_Experience_Cert_Attached__c,
        
        
        "Camp_Lejeune_CLCW_Expiration_Date__c": item.Camp_Lejeune_CLCW_Expiration_Date__c,
        "Camp_Lejeune_CLCW_Status__c": item.Camp_Lejeune_CLCW_Status__c,
        "Mental_Health_Cert_Expiration_Date__c": item.Mental_Health_Cert_Expiration_Date__c,
        "Mental_Health_Certification_Status__c": item.Mental_Health_Certification_Status__c,
        "Musculoskeletal_Exam_Expiration_Date__c": item.Musculoskeletal_Exam_Expiration_Date__c,
        "Musculoskeletal_Exam_Status__c": item.Musculoskeletal_Exam_Status__c,
        "PACT_Act_Expiration_Date__c": item.PACT_Act_Expiration_Date__c,
        "PACT_Act_Status__c": item.PACT_Act_Status__c,
        "Person_Contact_ID_from_Account__c": item.Person_Contact_ID_from_Account__c,
        "Separation_Health_Asses_Expiration_Date__c": item.Separation_Health_Asses_Expiration_Date__c,
        "Separation_Health_Assessment_Status__c": item.Separation_Health_Assessment_Status__c,
        "Spina_Bifida_Cert_Expiration_Date__c": item.Spina_Bifida_Cert_Expiration_Date__c,
        "Spina_Bifida_Examinations_Status__c": item.Spina_Bifida_Examinations_Status__c,
        "TBI_Exam_Expiration_Date_c__c": item.TBI_Exam_Expiration_Date__c,
        "TBI_Examination_Status__c": item.TBI_Examination_Status__c,
        "VES_General_Courses_Required__c": item.VES_General_Courses_Required__c,
        "VES_General_Courses_Expiration_Date__c": item.VES_General_Courses_Expiration_Date__c,
        
        "Aggravation_Expiration_Date__c": item.Aggravation_Expiration_Date__c,
        "Aggravation_Status__c": item.Aggravation_Status__c,
        "General_Certification_Expiration_Date__c": item.General_Certification_Expiration_Date__c,
        "General_Certification_Status__c": item.General_Certification_Status__c,
        "Gulf_War_Expiration_Date__c": item.Gulf_War_Expiration_Date__c,
        "Gulf_War_Status__c": item.Gulf_War_Status__c,
        "Last_Case_Completed_Date__c": item.Last_Case_Completed_Date__c,
        "Lethal_Means_Safety_Expiration_Date__c": item.Lethal_Means_Safety_Expiration_Date__c,
        "Lethal_Means_Safety_Status__c": item.Lethal_Means_Safety_Status__c,
        "Medical_Opinions_Expiration_Date__c": item.Medical_Opinions_Expiration_Date__c,
        "Medical_Opinions_Status__c": item.Medical_Opinions_Status__c,
        "Military_Culture_Expiration_Date__c": item.Military_Culture_Expiration_Date__c,
        "Military_Culture_Status__c": item.Military_Culture_Status__c,
        "Military_Sexual_Trauma_Expiration_Date__c": item.Military_Sexual_Trauma_Expiration_Date__c,
        "Military_Sexual_Trauma_Status__c": item.Military_Sexual_Trauma_Status,
        "Suicide_Awareness_Expiration_Date__c": item.Suicide_Awareness_Expiration_Date__c,
        "Suicide_Awareness_Status__c": item.Suicide_Awareness_Status__c,
        "Veteran_Experience_Expiration_Date__c": item.Veteran_Experience_Expiration_Date__c,
        "Veteran_Experience_Status__c": item.Veteran_Experience_Status__c,
        
        "X1151_Training_Completion_Date__c": item.X1151_Training__c,
        "X1151_Training_Expiration_Date__c": item.X1151_Training_Expiration_Date__c,
        "x1151_Training_Status__c": item.X1151_Training_Status__c,
        "POW_DQB_Training_Completion_Date__c": item.POW_DBQ_Training__c,
        "POW_DQB_Training_Expiration_Date__c": item.POW_DBQ_Training_Expiration_Date__c,
        "POW_DQB_Training_Status__c": item.POW_DBQ_Training_Status__c,
        
		"PNM_Last_Updated__c": now(),
        "PNM_Updated__c": "true"
       	
        
        

      }
  }]
      
})}