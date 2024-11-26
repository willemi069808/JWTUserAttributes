using UserInfoService as service from '../../srv/service';

annotate service.Users with @(UI: {
    Identification           : [{
        $Type : 'UI.DataFieldForAction',
        Action: 'UserInfoService.getAttributes',
        Label : 'Get JWT Attributes'
    }],
    HeaderInfo               : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'User',
        TypeNamePlural: 'Users',
        Title         : {Value: CAPInfo_id},
        TypeImageUrl  : 'sap-icon://account'
    },
    LineItem                 : [
        {Value: ID},
        {Value: CAPInfo_id},
        {Value: XSUAAInfo_user_id}
    ],
    Facets                   : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'facetCAP',
            Label : 'CAP User Information',
            Target: '@UI.FieldGroup#CAPUserInfo',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'facetXSUAA',
            Label : 'XSUAA User Information',
            Target: '@UI.FieldGroup#XSUAAUserInfo',
        }
    ],
    FieldGroup #CAPUserInfo  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: CAPInfo_id},
            {Value: CAPInfo_rolesList},
            {Value: CAPInfo_attr}
        ]
    },
    FieldGroup #XSUAAUserInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {Value: XSUAAInfo_user_id},
            {Value: XSUAAInfo_user_name},
            {Value: XSUAAInfo_given_name},
            {Value: XSUAAInfo_family_name},
            {Value: XSUAAInfo_email},
            {Value: XSUAAInfo_email_verified},
            {Value: XSUAAInfo_sub_idp},
            {Value: XSUAAInfo_previous_logon_time},
            {Value: XSUAAInfo_sub},
            {Value: XSUAAInfo_name}
        ]
    }
});
