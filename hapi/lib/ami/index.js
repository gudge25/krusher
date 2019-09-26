/*jshint node:true*/
'use strict';

const WS = require("ws");
const con = require('./src/ws-message');
const action = require('./src/ami-action');

const Joi = require("joi");
const AllAmiRun     = require('./src/AllAmi');

exports.register = (plugin, options, next) => {
    const server = plugin.select(['ws','wss']);
    //const server = plugin.select(['ws']);

    //непонято зачем, полагаю ето для старой тестировачной формы что в папке паблик лежит
    // server.route({
    //     method: 'GET',
    //     path: '/{param*}',
    //     handler: {
    //       directory: {
    //         path: 'public',
    //         redirectToSlash: true,
    //         index: true
    //       }
    //     },
    //     config: {
    //       auth: false
    //     }
    // });

    //Originate for WEB CallBack
    server.route({
        method: 'POST',
        path: '/originate',
        handler: (request, reply) => {
            const payload = request.payload;
            const params = {
                source: {
                    phone: payload.phone,
                    clID: payload.clID ? payload.clID : 0,
                    CallType : `101317`
                },
                exten: payload.exten,
                duration : null,
                isAutoCall: false,
                texttospeach: null, //payload.texttospeach,
                params : {
                    context         : payload.context           ? payload.context       : `office_${payload.Aid}`,
                    Aid             : payload.Aid               ? payload.Aid           : `null`,
                    //TTS settings
                    sum             : payload.sum               ? payload.sum           : `null`,
                    ttsText         : payload.ttsText           ? payload.ttsText       : `null`,
                    curName         : payload.curName           ? payload.curName       : `null`,
                    langName        : payload.langName          ? payload.langName      : `null`,
                    isFirstClient   : payload.isFirstClient,
                }
            };

            var Result = (err,data) => {
                if (err) { console.log(err); return reply(err); }
                //IF QTY NULL
                if (!data.qty && payload.context) {  return reply(`Not available SIP numbers for group ${payload.exten}, Qty: ${data.qty} `); }
                const GUID = action.originate(params);
                const msg = AllAmiRun.get(params.params.Aid);
                console.log(`=================Originate API ====================`);
                if(msg.ClientCalls > 12)
                    return reply(`Too many calls, QtyCalls: ${msg.ClientCalls}`);
                else
                return reply(`OK for group ${payload.exten}, Qty: ${data.qty}, QtyCalls: ${msg.ClientCalls}`);
            };

            //Check and Run Call
            if(!params.exten) return reply(`Not available exten`);
            if(!payload.phone) return reply(`Not available phone`);
            console.log(`=======Start Originate ======`);
            //amiAction.ShowDialPlan({ exten : params.exten, context: params.params.context, qty : 0 }, ProcessID);
            action.queuestatus({ exten : params.exten, qty : 0 }, Result );

        },
        config: {
            //auth: false,
            validate: {
                payload: {
                    Aid: Joi.number().integer().min(1).max(5000).required(),
                    phone: Joi.number().integer().min(10000000000).max(999999999999).required(),
                    exten: Joi.string().max(20).required(),
                    sum: Joi.number().integer().optional().allow(null),
                    ttsText: Joi.string().max(200).optional().allow(null),
                    curName: Joi.string().max(5).optional().allow(null),
                    langName: Joi.string().max(10).optional().allow(null),
                    texttospeach: Joi.string().max(200).optional().allow(null),
                    isFirstClient: Joi.boolean().optional().allow(null),
                    context: Joi.string().max(200).optional().allow(null),
                    clID: Joi.number().integer().optional().allow(null)
                }
            }
        }
    });

    //CREATE WSS Server
    const wssServer = plugin.select('wss');
    const wss = new WS.Server({
        server: wssServer.listener,
    });
    wss.on("connection", con);
    next();
};

exports.register.attributes = {
    name: 'hapi-ws'
};