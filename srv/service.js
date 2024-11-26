const cds = require('@sap/cds')

module.exports = (srv) => {
    srv.on('READ', srv.entities.Users, async req => {
        const userInfo = { ID: 1 }

        // Get user info from the CAP Request object
        try {
            Object.assign(userInfo, {
                CAPInfo_id: req.user.id,
                CAPInfo_roles: Object.keys(req.user.roles),
                CAPInfo_attr: Object.entries(req.user.attr).map(x => `${x[0]}: "${x[1]}"`).join(', ')
            })
        } catch (error) {
            console.log('Could not retrieve CAP user info:', error)
        }

        // Get user info from the XSUAA session
        try {
            const xsuaa_api = cds.env.requires['rest_api']
            xsuaa_api.credentials.url = JSON.parse(process.env.VCAP_SERVICES).xsuaa[0]?.credentials.url
            const xsuaa_srv = await cds.connect.to(xsuaa_api)
            const xsuaa_userinfo = await xsuaa_srv.get("/userinfo")
            for (key of Object.keys(xsuaa_userinfo)) {
                userInfo['XSUAAInfo_' + key] = key == 'previous_logon_time' ? new Date(xsuaa_userinfo[key]).toLocaleString() : xsuaa_userinfo[key]
            }
        } catch (error) {
            console.log('Could not retrieve XSUAA user info: ', error)
        }

        // Create oData result set
        const result = [userInfo]
        result.$count = result.length

        return req.reply(result)
    })
    srv.after('READ', srv.entities.Users, each => {
        try {
            each.CAPInfo_rolesList = each.CAPInfo_roles?.join(' ')
        } catch (error) {
            console.log('Could not retrieve CAPInfo_rolesList: ', error)
        }
    })
    srv.on('getAttributes', req => {
        try {
            const { attributes } = req.data
            let values = 'These are the values of the requested User Attributes in current JWT token:<br/><br/>'
            attributes.split(';').forEach(x => values += `- ${x}: ${req.user.attr[x] && req.user.attr[x] || req.user.attr[x]}<br/>`)
            return req.info(values)
        } catch (error) {
            return req.error('Could not retrieve Attributes: ', error)
        }
    })
}
