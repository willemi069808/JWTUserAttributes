namespace db;

type CAPUserInfo {
    id                : String          @title: 'CAP ID';
    roles             : array of String @title: 'Roles';
    virtual rolesList : String          @title: 'Roles';
    attr              : String          @title: 'Attributes';
};

type OpenIDConnectUserInfo {
    Email     : String @title: 'Email';
    FirstName : String @title: 'First Name';
    LastName  : String @title: 'Last Name';
    Sub       : String @title: 'Subject';
    Gender    : String @title: 'Gender';
    Mobile    : String @title: 'Mobile';
    Type      : String @title: 'Account Type';
};

type XSUAAUserInfo {
    user_id             : String  @title: 'XSUAA ID';
    user_name           : String  @title: 'User Name';
    given_name          : String  @title: 'Given Name';
    family_name         : String  @title: 'Family Name';
    email               : String  @title: 'Email';
    email_verified      : Boolean @title: 'Verified Email';
    sub_idp             : String  @title: 'Subject IdP';
    previous_logon_time : String  @title: 'Previous Logon Time';
    sub                 : String  @title: 'Subject';
    name                : String  @title: 'Name';
};

@cds.persistence.exists
entity Users {
    key ID        : Integer @title: 'App ID';
        CAPInfo   : CAPUserInfo;
        XSUAAInfo : XSUAAUserInfo;
        OIDCInfo  : OpenIDConnectUserInfo;
};
