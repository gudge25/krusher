/*jshint node:true*/
'use strict';
const Boom = require('boom');
const _ = require('lodash');
const PaginationLinks = require('src/util/pagination-links');
const Li = require('li');

class ReplyHelper {
    constructor(request, reply, model) {
        const constants = require('src/config/constants');
        this.request    = request;
        this.reply      = reply;
        this.model      = model;
        this.events     = request.server.events;
        this.url        = request.headers.host ? 'http://${ request.headers.host }' : constants.server.defaultHost;
    }

    replyFindOne(err, data) {
        if (err) return this.reply(Boom.conflict(err.message));
        if (data) {
            const entity = new this.model(data).Data;
            this.reply(entity);
        }
        else {
            this.reply({});
        }
    }

    replyPhp(err, data) {
        if (err) return this.reply(Boom.conflict(err.message));
        if (data) this.reply(data); else this.reply({});
    }

    replyFind(err, data, params) {
        let totalCount;
        let totalVoiceMin;
        let avgVoiceMin;
        let avgWaitMin;
        let avgBillMin;
        let info;
        const arr     = [];
        const self    = this;
        if (err) return this.reply(Boom.conflict(err));

        //MAPPING from Model
        data.forEach( value => {
            arr.push(new self.model(value).Data);
        });

        const linksHeader = PaginationLinks.create({
            url       : this.url + this.request.path,
            page      : this.request.query.page,
            perPage   : this.request.query.perPage,
            totalCount: data.length
        });

        //Add data array
        const response = this.reply(arr).hold();
        if (!_.isEmpty(linksHeader)) response.header('Link', Li.stringify(linksHeader));

        if (params) {
            if(params.qtyVoiceMin)
            {
                response.type('application/json').header('Total-SumMin', params.qtyVoiceMin ? params.qtyVoiceMin : '00:00:00');
                response.type('application/json').header('Total-AvgMin', params.avgVoiceMin ? params.avgVoiceMin : '00:00:00');
                response.type('application/json').header('Total-AvgWait', params.avgWaitMin ? params.avgWaitMin : '00:00:00');
                response.type('application/json').header('Total-AvgBill', params.avgBillMin ? params.avgBillMin : '00:00:00');
                response.type('application/json').header('Total-AvgHold', params.avgHoldMin ? params.avgHoldMin : '00:00:00');
            }
            if(params.LostBefore20sec) {
                response.type('application/json').header('CallsCount', (params.CallsCount ? params.CallsCount : 0));
                response.type('application/json').header('ReceivedBefore20sec', (params.ReceivedBefore20sec ? params.ReceivedBefore20sec : 0));
                response.type('application/json').header('ReceivedBefore20secPercent', (params.ReceivedBefore20secPercent ? params.ReceivedBefore20secPercent : 0));
                response.type('application/json').header('ReceivedBefore30sec', (params.ReceivedBefore30sec ? params.ReceivedBefore30sec : 0));
                response.type('application/json').header('ReceivedBefore30secPercent', (params.ReceivedBefore30secPercent ? params.ReceivedBefore30secPercent : 0));
                response.type('application/json').header('ReceivedBefore60sec', (params.ReceivedBefore60sec ? params.ReceivedBefore60sec : 0));
                response.type('application/json').header('ReceivedBefore60secPercent', (params.ReceivedBefore60secPercent ? params.ReceivedBefore60secPercent : 0));
                response.type('application/json').header('ReceivedAfter60sec', (params.ReceivedAfter60sec ? params.ReceivedAfter60sec : 0));
                response.type('application/json').header('ReceivedAfter60secPercent', (params.ReceivedAfter60secPercent ? params.ReceivedAfter60secPercent : 0));
                response.type('application/json').header('ReceivedCalls', (params.ReceivedCalls ? params.ReceivedCalls : 0));
                response.type('application/json').header('LostBefore20sec', (params.LostBefore20sec ? params.LostBefore20sec : 0));
                response.type('application/json').header('LostBefore20secPercent', (params.LostBefore20secPercent ? params.LostBefore20secPercent : 0));
                response.type('application/json').header('LostBefore30sec', (params.LostBefore30sec ? params.LostBefore30sec : 0));
                response.type('application/json').header('LostBefore30secPercent', (params.LostBefore30secPercent ? params.LostBefore30secPercent : 0));
                response.type('application/json').header('LostBefore60sec', (params.LostBefore60sec ? params.LostBefore60sec : 0));
                response.type('application/json').header('LostBefore60secPercent', (params.LostBefore60secPercent ? params.LostBefore60secPercent : 0));
                response.type('application/json').header('LostAfter60sec', (params.LostAfter60sec ? params.LostAfter60sec : 0));
                response.type('application/json').header('LostAfter60secPercent', (params.LostAfter60secPercent ? params.LostAfter60secPercent : 0));
                response.type('application/json').header('LostCalls', (params.LostCalls ? params.LostCalls : 0));
                response.type('application/json').header('AHT', (params.AHT ? params.AHT : 0));
                response.type('application/json').header('SL', (params.SL ? params.SL : 0));
                response.type('application/json').header('LCR', (params.LCR ? params.LCR : 0));
                response.type('application/json').header('ATT', (params.ATT ? params.ATT : 0));
            }
            if(params.HT) {
                response.type('application/json').header('CallsCount', (params.CallsCount ? params.CallsCount : 0));
                response.type('application/json').header('LostBefore5sec', (params.LostBefore5sec ? params.LostBefore5sec : 0));
                response.type('application/json').header('LostBefore5secPercent', (params.LostBefore5secPercent ? params.LostBefore5secPercent : 0));
                response.type('application/json').header('LostBefore30sec', (params.LostBefore30sec ? params.LostBefore30sec : 0));
                response.type('application/json').header('LostBefore30secPercent', (params.LostBefore30secPercent ? params.LostBefore30secPercent : 0));
                response.type('application/json').header('LostAfter30sec', (params.LostAfter30sec ? params.LostAfter30sec : 0));
                response.type('application/json').header('LostAfter30secPercent', (params.LostAfter30secPercent ? params.LostAfter30secPercent : 0));
                response.type('application/json').header('ReceivedCalls', (params.ReceivedCalls ? params.ReceivedCalls : 0));
                response.type('application/json').header('ReceivedBefore20sec', (params.ReceivedBefore20sec ? params.ReceivedBefore20sec : 0));
                response.type('application/json').header('ReceivedBefore20secPercent', (params.ReceivedBefore20secPercent ? params.ReceivedBefore20secPercent : 0));
                response.type('application/json').header('ReceivedBefore30sec', (params.ReceivedBefore30sec ? params.ReceivedBefore30sec : 0));
                response.type('application/json').header('ReceivedBefore30secPercent', (params.ReceivedBefore30secPercent ? params.ReceivedBefore30secPercent : 0));
                response.type('application/json').header('ReceivedAfter30sec', (params.ReceivedAfter30sec ? params.ReceivedAfter30sec : 0));
                response.type('application/json').header('ReceivedAfter30secPercent', (params.ReceivedAfter30secPercent ? params.ReceivedAfter30secPercent : 0));
                response.type('application/json').header('LostCalls', (params.LostCalls ? params.LostCalls : 0));
                response.type('application/json').header('AHT', (params.AHT ? params.AHT : 0));
                response.type('application/json').header('SL', (params.SL ? params.SL : 0));
                response.type('application/json').header('LCR', (params.LCR ? params.LCR : 0));
                response.type('application/json').header('ATT', (params.ATT ? params.ATT : 0));
                response.type('application/json').header('HT', (params.HT ? params.HT : 0));
                response.type('application/json').header('Recalls', (params.Recalls ? params.Recalls : 0));
                response.type('application/json').header('RLCR', (params.RLCR ? params.RLCR : 0));
            }
            totalCount = params.qty ? params.qty : arr.length;
            response.type('application/json').header('Total-Count', totalCount).send();
        }
        else {
            totalCount = arr.length;
            response.type('application/json').header('Total-Count', totalCount).send();
        }
    }

    replyInsert(err, rows) {
        if (err) return this.reply(Boom.conflict(err.message));
        if(this.request.path != "/api/ast/monitoring"){
            // console.log(`this.events============================================================================`);
            // console.log(this.events);
            this.events.emit('events', {
                event: 'create',
                data: {
                    route: this.request.path,
                    data: rows
                },
                payload: this.request.payload
            });
        }
        return this.reply(rows).code(201);
    }

    replyUpdate(err, rows) {
        if (err) return this.reply(Boom.conflict(err.message));
        this.events.emit('events', {
            event: 'update',
            data: {
                route: this.request.path,
                data: rows
            },
            payload: this.request.payload
        });
        this.reply(rows).code(204);
    }

    replyDelete(err, rows) {
        if (err) return this.reply(Boom.conflict(err.message));
        this.events.emit('events', {
            event: 'remove',
            data: {
                route: this.request.path,
                data: rows
            }
        });
        this.reply(rows).code(204);
    }
}
module.exports = ReplyHelper;