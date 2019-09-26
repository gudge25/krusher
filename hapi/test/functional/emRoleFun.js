'use strict';

// requires for testing
const Code = require('code');
const expect = Code.expect;
const Lab = require('lab');
const lab = exports.lab = Lab.script();

// use some BDD verbage instead of lab default
const describe = lab.describe;
const it = lab.it;
const after = lab.after;

// require hapi server
const Server = require('../../index.js');

// tests
describe('functional tests - emRole', () => {
  it('should get emRole', (done) => {
    // make API call to self to test functionality end-to-end
    Server.inject({
      method: 'GET',
      url: '/api/em/roles'
    }, (response) => {

      // expect(response.statusCode).to.equal(200);
      // expect(response.result.result).to.have.length(4);
      done();
    });
  });

  it('should get single emRole', (done) => {

    Server.inject({
      method: 'GET',
      url: '/api/em/roles/1'
    }, (response) => {

      // expect(response.statusCode).to.equal(200);
      done();
    });
  });

  after((done) => {

    // placeholder to do something post tests
    done();
  });
});

// describe('functional tests - get documentation', () => {

//   it('should return documentation html', (done) => {

//     // make API call to self to test functionality end-to-end
//     Server.inject({
//       method: 'GET',
//       url: '/'
//     }, (response) => {

//       expect(response.statusCode).to.equal(200);
//       expect(response.result).to.be.a.string();
//       done();
//     });
//   });

//   after((done) => {

//     // placeholder to do something post tests
//     done();
//   });
// });
