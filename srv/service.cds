using db from '../db/schema';

@(requires: 'authenticated-user')
service UserInfoService {
    @readonly
    entity Users as projection on db.Users
        actions {
            action getAttributes(
                                 @title:'Attributes (semi-colon separated)'
                                 @UI.ParameterDefaultValue:'origin;sub;iss;exp;iat;email;gender;mobile;lastnameEN;fullnameEN;uuid;nationalityEN;firstnameEN;userType;nationalityAR'
                                 attributes : String) returns Boolean;
        };
}
