public with sharing class EmailTemplateUtils {
    public static String processToString(String templateId, Id mergeObjectId) { 
        // based on https://salesforce.stackexchange.com/questions/13/using-apex-to-assemble-html-letterhead-emails/8745#8745
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'invalid@emailaddr.es'};
        mail.setToAddresses(toAddresses);
        mail.setUseSignature(false);
        mail.setSaveAsActivity(false);
        mail.setSenderDisplayName('MMPT');
        mail.setTreatTargetObjectAsRecipient(false);
       //mail.setTargetObjectId(UserInfo.getUserId());
        mail.setTargetObjectId([select Id from Contact limit 1].Id);
        mail.setWhatId(mergeObjectId);
        mail.setTemplateId(templateId);
        Savepoint sp = Database.setSavepoint();
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        Database.rollback(sp);
        String mailTextBody = MergeText(mail.getPlainTextBody(), [select Id from Task limit 1]);
        //String mailHtmlBody = mail.getHTMLBody();
        //String mailSubject = mail.getSubject();
        return mailTextBody;
    }
    
    public static String mergeText(String source, SObject obj){
        System.debug('>>>'+source);
        String s = '';      
        if(source != null && obj != null){
            Integer curPos = 0;
            Pattern mergeField = Pattern.compile('\\{![a-zA-Z0-9_\\.]*\\}');
            Matcher m = mergeField.matcher(source);
            while(m.find()){
                //add the piece of text from the end of the previous match
                //until the start of this one.
                s += source.substring(curPos, m.start());
                //get the actual field name (without {! })
                String fieldName = source.substring(m.start()+2,m.end()-1);
                //split the fieldname to get the different relations as parts
                String[] relations = fieldName.split('\\.');
    
                try {
                    //iterate over the relations to get to the object that's needed.
                    SObject tmp = obj;
        System.debug('>>>rel:'+relations);
        System.debug('>>>tmp:'+tmp);
                    for(Integer i=0; i<relations.size()-1; i++){
                        if (i==0) continue;
                        tmp = tmp.getSObject(relations[i]);
        System.debug('>>>rel:'+relations[i]);
                    }
                    //now get the value of the field
                    s += tmp.get(relations[relations.size()-1]);
                } catch(Exception ex){
                    s += '[Invalid merge field: ' + m.group() + ']';
                }
                curPos = m.end();
            }
            //add the end of the original string
            s += source.substring(curPos);
        }
        return s;
    }
     
}
