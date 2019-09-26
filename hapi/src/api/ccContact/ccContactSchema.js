const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class ccContactSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            dcID: Joi.number().integer().optional().allow(null).description('ID document'),
            ccID: Joi.number().integer().optional().allow(null).description('Calling card ID'),
            ccName: Joi.string().max(50).optional().allow(null).description('Phone or email'),
            IsOut: Joi.bool().optional().allow(null).description('Sign "Outgoing call"'),
            SIP: Joi.string().max(50).optional().allow(null).description('SIP number'),
            LinkFile: Joi.string().max(200).optional().allow(null).description('Link to file mp3'),
            duration: Joi.number().integer().optional().allow(null).description('Duration of call'),
            billsec: Joi.number().integer().optional().allow(null).description('Duration of talking'),
            holdtime: Joi.number().integer().optional().allow(null).description('Duration of ringing'),
            channel: Joi.string().max(50).optional().allow(null).description('trunk'),
            isAutocall: Joi.bool().optional().allow(null).description('Auto-call sign'),
            CauseCode: Joi.number().integer().allow(null),
            CauseDesc: Joi.string().allow(null),
            CauseWho: Joi.number().integer().allow(null),
            Queue: Joi.string().max(128).allow(null),
            CallType: Joi.number().integer().allow(null),
            id_autodial: Joi.number().integer().allow(null).description('Autodial process ID'),
            id_scenario: Joi.number().integer().allow(null).description('Scenario ID'),
            emID: Joi.alternatives().try(Joi.number().integer().optional().allow(null), Joi.allow(null)).description('Manager ID'),
            clID: Joi.alternatives().try(Joi.number().integer().optional().allow(null), Joi.allow(null)).description('Client ID'),
            ffID: Joi.number().integer().allow(null).description('Group ID'),
            disposition: Joi.string().max(50).optional().allow(null).description('Calling status'),
            target: Joi.string().max(255).optional().allow(null).description('Этапы для достижения цели'),
            coID: Joi.alternatives().try(Joi.number().integer().optional().allow(null), Joi.allow(null)).description('Company ID'),
            destination: Joi.number().integer().allow(null),
            destdata: Joi.number().integer().allow(null),
            destdata2: Joi.string().max(100).allow(null),
            transferFrom: Joi.array().items(Joi.number().integer().allow(null)),
            transferTo: Joi.array().items(Joi.number().integer().allow(null)),
            Comment: Joi.string().max(250).allow(null),
            ContactStatuses: Joi.number().integer().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Calling Card';
        const params = { schema, name };
        super(params);
    }

    schemaFind() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            dcIDs: Joi.array().items(Joi.number().integer().allow(null).description('Item ID')).allow(null),
            emIDs: Joi.array().items(Joi.number().integer().allow(null).description('Employee ID')).allow(null),
            dcStatuss: Joi.array().items(Joi.number().integer().allow(null).description('status calling card')).allow(null),
            ffIDs: Joi.array().items(Joi.number().integer().allow(null).description('File ID')).allow(null),
            isMissed: Joi.bool().allow(null).description('missed calls'),
            isUnique: Joi.bool().allow(null).description('unique calls'),
            CallTypes: Joi.array().items(Joi.number().integer().allow(null).description('us/enums tyID=1013')).allow(null),
            ccNames: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            channels: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
            comparison: Joi.string().max(1).allow(null),
            billsec: Joi.number().integer().allow(null),
            clIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            IsOut: Joi.bool().allow(null).description('Incoming or Outcoming call'),
            id_autodials: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            id_scenarios: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            ManageIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            target: Joi.string().max(255).allow(null,true,false),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            destination: Joi.number().integer().allow(null),
            destdata: Joi.number().integer().allow(null),
            destdata2: Joi.string().max(100).allow(null),
            ContactStatuses: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            isActive: Joi.boolean().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }

    schemaFindExport() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            dcIDs: Joi.array().items(Joi.number().integer().allow(null).description('Item ID')).allow(null),
            emIDs: Joi.array().items(Joi.number().integer().allow(null).description('Employee ID')).allow(null),
            dcStatuss: Joi.array().items(Joi.number().integer().allow(null).description('status calling card')).allow(null),
            ffIDs: Joi.array().items(Joi.number().integer().allow(null).description('File ID')).allow(null),
            isMissed: Joi.bool().allow(null).description('missed calls'),
            isUnique: Joi.bool().allow(null).description('unique calls'),
            CallTypes: Joi.array().items(Joi.number().integer().allow(null).description('us/enums tyID=1013')).allow(null),
            ccNames: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            channels: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
            comparison: Joi.string().max(1).allow(null),
            billsec: Joi.number().integer().allow(null),
            clIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            IsOut: Joi.bool().allow(null).description('Incoming or Outcoming call'),
            id_autodials: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            id_scenarios: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            ManageIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            target: Joi.string().max(255).allow(null,true,false),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            destination: Joi.number().integer().allow(null),
            destdata: Joi.number().integer().allow(null),
            destdata2: Joi.string().max(100).allow(null),
            ContactStatuses: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            url: Joi.string().max(300).allow(null),
            isActive: Joi.boolean().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }

    schemaFindRecords() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            dcIDs: Joi.array().items(Joi.number().integer().allow(null).description('Item ID')).allow(null),
            emIDs: Joi.array().items(Joi.number().integer().allow(null).description('Employee ID')).allow(null),
            dcStatuss: Joi.array().items(Joi.number().integer().allow(null).description('status calling card')).allow(null),
            ffIDs: Joi.array().items(Joi.number().integer().allow(null).description('File ID')).allow(null),
            isMissed: Joi.bool().allow(null).description('missed calls'),
            isUnique: Joi.bool().allow(null).description('unique calls'),
            CallTypes: Joi.array().items(Joi.number().integer().allow(null).description('us/enums tyID=1013')).allow(null),
            ccNames: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            channels: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
            comparison: Joi.string().max(1).allow(null),
            billsec: Joi.number().integer().allow(null),
            clIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            IsOut: Joi.bool().allow(null).description('Incoming or Outcoming call'),
            id_autodials: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            id_scenarios: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            ManageIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            target: Joi.string().max(255).allow(null,true,false),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            destination: Joi.number().integer().allow(null),
            destdata: Joi.number().integer().allow(null),
            destdata2: Joi.string().max(100).allow(null),
            ContactStatuses: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            convertFormat: Joi.number().integer().allow(null),
            isActive: Joi.boolean().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }
    schemaInsert() {
        const obj = Object.assign({}, this.schema);
        return {
            "Aid": Joi.number().integer().required(),
            "dcID": obj.dcID,
            "ccName": obj.ccName,
            "ccID": obj.ccID,
            "IsOut": obj.IsOut,
            "disposition": obj.disposition,
            "clID": obj.clID,
            "SIP": obj.SIP,
            "emID": obj.emID,
            "LinkFile": obj.LinkFile,
            "duration": obj.duration,
            "billsec": obj.billsec,
            "holdtime": obj.holdtime,
            "channel": obj.channel,
            "isAutocall": obj.isAutocall,
            "CauseCode": obj.CauseCode,
            "CauseDesc": obj.CauseDesc,
            "CauseWho": obj.CauseWho,
            "CallType": obj.CallType,
            "id_autodial": obj.id_autodial,
            "id_scenario": obj.id_scenario,
            "ffID": obj.ffID,
            "target": obj.target,
            "coID": obj.coID,
            "destination": obj.destination,
            "destdata": obj.destdata,
            "destdata2": obj.destdata2,
            "transferFrom": obj.transferFrom,
            "transferTo": obj.transferTo,
            "isAsterisk": obj.isActive,
            "isActive": obj.isActive
        };
    }

    schemaUpdate() {
        const obj = Object.assign({}, this.schema);
        return {
            "dcID": obj.dcID,
            "ccName": obj.ccName,
            "ccID": obj.ccID,
            "IsOut": obj.IsOut,
            "disposition": obj.disposition,
            "clID": obj.clID,
            "SIP": obj.SIP,
            "emID": obj.emID,
            "LinkFile": obj.LinkFile,
            "duration": obj.duration,
            "billsec": obj.billsec,
            "holdtime": obj.holdtime,
            "channel": obj.channel,
            "isAutocall": obj.isAutocall,
            "CauseCode": obj.CauseCode,
            "CauseDesc": obj.CauseDesc,
            "CauseWho": obj.CauseWho,
            "CallType": obj.CallType,
            "id_autodial": obj.id_autodial,
            "id_scenario": obj.id_scenario,
            "ffID": obj.ffID,
            "target": obj.target,
            "coID": obj.coID,
            "destination": obj.destination,
            "destdata": obj.destdata,
            "destdata2": obj.destdata2,
            "transferFrom": obj.transferFrom,
            "transferTo": obj.transferTo,
            "Comment": obj.Comment,
            "ContactStatus": Joi.number().integer().optional().allow(null),
            "isAsterisk": obj.isActive,
            "isActive": obj.isActive
        };
    }

    schemadailyHour() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            emIDs: Joi.array().items(Joi.number().integer().allow(null).description('Employee ID')).allow(null),
            channels: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
            IsOut: Joi.bool().allow(null).description('Incoming or Outcoming call'),
            CallTypes: Joi.array().items(Joi.number().integer().allow(null).description('us/enums tyID=1013')).allow(null),
            ffIDs: Joi.array().items(Joi.number().integer().allow(null).description('File ID')).allow(null),
            ContactStatuses: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            clIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            ManagerIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            targets: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
        };
    }

    schemaRecordsList() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            statusReady: Joi.string().max(50).optional().allow(null).description('status'),
            convertFormat: Joi.number().integer().allow(null),
            isActive: Joi.boolean().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }

    schemaRecordsListDelete() {
        return {
            idCR: Joi.number().integer().optional().allow(null),
        };
    }

    schemadailyReport() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            emIDs: Joi.array().items(Joi.number().integer().allow(null).description('Employee ID')).allow(null),
            channels: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
            IsOut: Joi.bool().allow(null).description('Incoming or Outcoming call'),
            CallTypes: Joi.array().items(Joi.number().integer().allow(null).description('us/enums tyID=1013')).allow(null),
            ffIDs: Joi.array().items(Joi.number().integer().allow(null).description('File ID')).allow(null),
            ContactStatuses: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            clIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            ManagerIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            targets: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
            step: Joi.number().integer().allow(null).description('0 - by hour, 1 - by days'),
        };
    }

    schemadailyCalls() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            dcIDs: Joi.array().items(Joi.number().integer().allow(null).description('Item ID')).allow(null),
            emIDs: Joi.array().items(Joi.number().integer().allow(null).description('Employee ID')).allow(null),
            dcStatuss: Joi.array().items(Joi.number().integer().allow(null).description('status calling card')).allow(null),
            ffIDs: Joi.array().items(Joi.number().integer().allow(null).description('File ID')).allow(null),
            isMissed: Joi.bool().allow(null).description('missed calls'),
            isUnique: Joi.bool().allow(null).description('unique calls'),
            CallTypes: Joi.array().items(Joi.number().integer().allow(null).description('us/enums tyID=1013')).allow(null),
            ccNames: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            channels: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
            comparison: Joi.string().max(1).allow(null),
            billsec: Joi.number().integer().allow(null),
            clIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            IsOut: Joi.bool().allow(null).description('Incoming or Outcoming call'),
            id_autodials: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            id_scenarios: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            ManageIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            target: Joi.string().max(255).allow(null),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            destination: Joi.number().integer().allow(null),
            destdata: Joi.number().integer().allow(null),
            destdata2: Joi.string().max(100).allow(null),
            ContactStatuses: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            isActive: Joi.boolean().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }

    schemadailyStatuses() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            emIDs: Joi.array().items(Joi.number().integer().allow(null).description('Employee ID')).allow(null),
            channels: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
            IsOut: Joi.bool().allow(null).description('Incoming or Outcoming call'),
            CallTypes: Joi.array().items(Joi.number().integer().allow(null).description('us/enums tyID=1013')).allow(null),
            ffIDs: Joi.array().items(Joi.number().integer().allow(null).description('File ID')).allow(null),
            ContactStatuses: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            clIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            ManagerIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            targets: Joi.array().items(Joi.string().max(128).allow(null)).allow(null),
        };
    }

    schemafileExport() {
        const obj = Object.assign({}, this.schemaFind());
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            emIDs: Joi.array().items(Joi.number().integer().allow(null,true,false).description('Employee ID')),
            dcStatuss: Joi.array().items(Joi.number().integer().allow(null,true,false).description('status calling card')),
            ffIDs: Joi.array().items(Joi.number().integer().allow(null,true,false).description('File ID')),
            isMissed: obj.isMissed,
            isUnique: obj.isUnique,
            CallTypes: Joi.array().items(Joi.number().integer().allow(null,true,false).description('us/enums tyID=1013')),
            ccNames: Joi.array().items(Joi.number().integer().allow(null,true,false)),
            channels: Joi.array().items(Joi.number().integer().max(128).allow(null,true,false)),
            comparison: obj.comparison,
            billsec: obj.billsec,
            clIDs: Joi.array().items(Joi.number().integer().allow(null,true,false)),
            IsOut: obj.IsOut,
            id_autodials: Joi.array().items(Joi.number().integer().allow(null,true,false)),
            id_scenarios: Joi.array().items(Joi.number().integer().allow(null,true,false)),
            target: Joi.string().max(255).allow(null),
        };
    }

    schemaGetMissed() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            IsOut: Joi.bool().allow(null).description('Incoming or Outcoming call'),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            emIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            ManageIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
        };
    }
}

module.exports = ccContactSchema;