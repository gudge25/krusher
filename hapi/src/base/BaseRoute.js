/*jshint node:true, esnext:true*/
'use strict';

class BaseRoute {
  constructor(params) {
    this.id = params.id;
    this.route = params.route;
    this.ctrl = params.ctrl;
    this.validate = params.validate;
    this.routes = {
      findByID: {
        method: `GET`,
        path: `${this.route}/{${this.id}}`,
        handler: this.ctrl.findByID,
        config: {
          validate: this.validate.findByID,
        }
      },
      find: {
        method: `GET`,
        path: `${this.route}`,
        handler: this.ctrl.find,
      },
      insert: {
        method: `POST`,
        path: `${this.route}`,
        handler: this.ctrl.insert,
        config: {
          validate: this.validate.insert
        }
      },
      update: {
        method: `PUT`,
        path: `${this.route}/{${this.id}}`,
        handler: this.ctrl.update,
        config: {
          validate: this.validate.update
        }
      },
      remove: {
        method: `DELETE`,
        path: `${this.route}/{${this.id}}`,
        handler: this.ctrl.delete,
        config: {
          validate: this.validate.delete
        }
      }
    };
  }
  getAllRoutes() {
    const arr = [];
    for (let key in this.routes) {
      arr.push(this.routes[key]);
    }
    return arr;
  }
  getRoute(method, route, handler, validate) {
    const jsn = {
      method: method,
      route: route,
      handler: handler
    };
    if(validate) {
      jsn.config = {
        validate: validate
      };
    }
    return jsn;
  }
}

module.exports = BaseRoute;