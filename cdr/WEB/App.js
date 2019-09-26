'use strict';
window.location='#/';
console.log(window.screen.width);
const app = angular.module('App', [
					
					'LocalStorageModule',
					'mediaPlayer',
					'infiniteScroll',
					'mgcrea.ngStrap',
					'mgcrea.ngStrap.navbar',
					'mgcrea.ngStrap.datepicker',
					'mgcrea.ngStrap.helpers.dateParser',
					'mgcrea.ngStrap.tooltip',
					'ngAnimate','highcharts-ng', 'ui.router',
					//'ngSanitize',
					'ngCsv',
					'angular-md5',
					'ngDragDrop'
					]);

const h = `http://${window.location.hostname}/WEB/REST/service.php?`;

const API = {
    "active": `${h}active`,
    "cdrColumn": `${h}cdr_column`,
	"record": `${h}url`,
	"cdr": `${h}cdr`,
	"comment": `${h}cdr_save=save`
};
// var api = 'http://sip.asterisk.if.ua:8088/ari/';
// var api_key='&api_key=ari:ari';
// var api2 = 'http://cdr.asterisk.biz.ua/WEB/REST/service.php?';
// var api_node_post = 'http://asterisk.biz.ua:3001/';
// var api_node_get = 'http://asterisk.biz.ua:3000/';
//${window.location.hostname}:3000`,