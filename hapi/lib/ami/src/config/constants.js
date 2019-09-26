/*jshint node:true*/
'use strict';
module.exports = (() => {
  const env = process.env.NODE_ENV || 'development';
  const appConstants = applicationConfig();
  const amiContants = amiConfig();
  const obj = {
    application: {
      url: appConstants[env].url,
      host: appConstants[env].host,
      port: appConstants[env].port
    },
    ami: {
      host: amiContants[env].host,
      user: amiContants[env].user,
      password: amiContants[env].password,
      port: amiContants[env].port,
    },
    server: {
      defaultHost: 'https://localhost:3010',
    },
  };
  if (!obj.application.host) {
    throw new Error(`Missing constant application.host. Check your enviroment variables NODE_HOST.`);
  } else if (!obj.application.port) {
    throw new Error(`Missing constant application.port. Check your enviroment variable NODE_PORT.`);
  } else if (!obj.ami.host) {
    throw new Error(`Missing constant ami.host. Check your enviroment variables.`);
  } else if (!obj.ami.user) {
    throw new Error(`Missing constant ami.user. Check your enviroment variables.`);
  } else if (!obj.ami.password) {
    throw new Error(`Missing constant ami.password. Check your enviroment variables.`);
  } else if (!obj.ami.port) {
    throw new Error(`Missing constant ami.port. Check your enviroment variables.`);
  }
  return obj;

  function amiConfig() {
    return {
      'production': {
        'host': process.env.AMI_PRD_HOST,
        'user': process.env.AMI_PRD_USER,
        'password': process.env.AMI_PRD_PASS,
        'port': process.env.AMI_PRD_PORT,
      },
      'development': {
        'host': process.env.AMI_DEV_HOST,
        'user': process.env.AMI_DEV_USER,
        'password': process.env.AMI_DEV_PASS,
        'port': process.env.AMI_DEV_PORT,
      },
      'test': {
        'host': process.env.AMI_TEST_HOST,
        'user': process.env.AMI_TEST_USER,
        'password': process.env.AMI_TEST_PASS,
        'port': process.env.AMI_TEST_PORT,
      }
    };
  }

  function applicationConfig() {
    return {
      'production': {
        'url': `https://${ process.env.NODE_HOST }:${ process.env.NODE_PORT }`,
        'host': process.env.NODE_HOST,
        'port': process.env.NODE_PORT
      },
      'development': {
        'url': `https://${ process.env.NODE_HOST }:${ process.env.NODE_PORT }`,
        'host': process.env.NODE_HOST,
        'port': process.env.NODE_PORT
      },
      'test': {
        'url': `https://${ process.env.NODE_HOST }:${ process.env.NODE_PORT }`,
        'host': process.env.NODE_HOST,
        'port': process.env.NODE_PORT
      }
    };
  }
})();
