/*jshint node:true, esnext:true*/
'use strict';
const Joi = require('joi');
//const ReplyHelper = require('src/base/reply-helper');

function BaseConfig(params) {
    const validate = params.validate;
    const handlers = params.handlers;
    const schema = params.schema;
    const schemaError = schema.Error;

    const schemaFindByID = schema.schemaFindByID();
    const schemaFind = schema.schemaFind();
   // const schemaLookup = schema.schemaLookup();

    const config = {
        findByID: {
            description: 'Get by ID',
            tags: ['api'],
            validate: validate.findByID,
            handler: handlers.findByID,
            plugins: {
                'hapi-swagger': {
                    responses: {
                        '200': {
                            description: 'Success',
                            schema: Joi.object({
                            result: schemaFindByID
                            }).label('Response')
                        },
                        '400': { description: 'Bad Request', schema: schemaError }
                    },
                    security: {}
                }
            }
        },
        find: {
            handler: handlers.find,
            description: 'Find',
            plugins: {
                'hapi-swagger': {
                    responses: {
                        '200': {
                            description: 'Success',
                            schema: Joi.object({
                                result: Joi.array().items(schemaFind)
                            }).label('Response')
                        },
                        '400': { description: 'Bad Request', schema: schemaError }
                    },
                    security: {}
                }
            },
            tags: ['api'],
            validate: validate.find
        },
        findPost: {
            handler: handlers.findPost,
            description: 'Find by any field',
            plugins: {
                'hapi-swagger': {
                    responses: {
                    '200': {
                        description: 'Success',
                        schema: Joi.object({
                            result: Joi.array().items(schema.schemaFindPost())
                        }).label('Response')
                    },
                    '400': { description: 'Bad Request', schema: schemaError }
                    },
                    security: {}
                }
            },
            tags: ['api'],
            validate: validate.findPost
        },
        lookup: {
            handler: handlers.lookup,
            description: 'Lookup',
            plugins: {
                'hapi-swagger': {
                    responses: {
                        '200': {
                            description: 'Success',
                            schema: Joi.object({
                                result: Joi.array().items(schemaFind)
                            }).label('Response')
                        },
                        '400': { description: 'Bad Request', schema: schemaError }
                    },
                    security: {}
                }
            },
            tags: ['api'],
            validate: validate.lookup
        },
        insert: {
            handler: handlers.insert,
            description: 'Add',
            tags: ['api'],
            validate: validate.insert
        },
        update: {
            handler: handlers.update,
            description: 'Update',
            tags: ['api'],
            validate: validate.update
        },
        delete: {
            handler: handlers.delete,
            description: 'Remove',
            tags: ['api'],
            validate: validate.delete
        },
    };
    return config;
}

module.exports = BaseConfig;
