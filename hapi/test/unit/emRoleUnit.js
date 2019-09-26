'use strict';

// requires for testing
const Code = require('code');
const expect = Code.expect;
const Lab = require('lab');
const lab = exports.lab = Lab.script();
const auth = require('test/auth-unit');

// use some BDD verbage instead of lab default
const describe = lab.describe;
const it = lab.it;

// we require the handlers directly, so we can test the "Lib" functions in isolation
const model = require('src/api/emRole/emRoleModel');

describe('unit tests - emRole', () => {

  it('should return all emRole', (done) => {

    // test lib function
    model.repoFind(auth.getParams(), (err, roles) => {
      if (err) return done(err);
      expect(roles[0]).to.be.an.array().and.have.length(4);

      done();

    });
  });
  it('should return single emRole', (done) => {

    model.repoFindByID(auth.getParams(1), (err, role) => {
      if (err) return done(err);
      expect(role[0][0]).to.be.an.object();

      done();
    });
  });
});
