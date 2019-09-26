// get ag-Grid to create an Angular module and register the ag-Grid directive
//agGrid.initialiseAgGridWithAngular1(angular);
const crmUA = angular.module('crmUA', [
                                        'ui.bootstrap',
                                        'ui.bootstrap.datetimepicker',
                                        'ui.router',
                                        'ui.select',
                                        'ui.checkbox',
                                        'ui.grid',
                                        //'ngTable',
                                        //'ngOptionsDisabled',
                                        'ngMap',
                                        // 'ngMapAutocomplete',
                                        'highcharts-ng',
                                        'ds.clock',
                                        'infiniteScroll',
                                        'angular-bind-html-compile',
                                        'angularjs-dropdown-multiselect',
                                        'ngWindowManager',
                                        'monospaced.elastic',
                                        'kendo.directives',
                                        'htmlToPdfSave',
                                        'pascalprecht.translate',
                                        'ng-acl',
                                        'ngAudio',
                                        'angular-toArrayFilter',
                                        'cbSwitch',
                                        'moment-picker',
                                        'nzToggle'
                                     ]);

// GULP URL FOR ROUTE
var Gulp = "build/";

//BASE auth headers
var [USERNAME,PASSWORD,SIP,EMID,TRIFF,eventSource] = [null,null,null,null,null,null];

var IfAuth = JSON.parse(localStorage.getItem('Auth'));
if(IfAuth){
    [USERNAME,PASSWORD,SIP,EMID] = [IfAuth.LoginName,atob(IfAuth.PASSWORD),IfAuth.sipLogin,IfAuth.emID];
    if(SIP) wsStart();

    if(window.location.hash == "#!/login" || window.location.hash === "")  window.location = window.location = "#!/Dashboard";
}

//For NBR auto open modal
// setTimeout( () => {
// 	var AModal = JSON.parse(localStorage.getItem('ActualizationModal'));
// 	if(AModal) angular.element(document.getElementById('wsPopupCtrl')).scope().openClientNBR(AModal.clID);
// }, 1200);

// //FOR open onli one tab
// window.onload = () => {
//   let tabCnt = localStorage.getItem("tabCnt");
//   if (tabCnt <= 0) tabCnt = 0;
//   else  {
//            throw new Error('Dublicate tabs');
//         }
//   localStorage.setItem("tabCnt", ++tabCnt);
// };
// window.onbeforeunload = e => {
//   let tabCnt = localStorage.getItem("tabCnt");
//   if (!tabCnt) tabCnt = 0;
//   localStorage.setItem("tabCnt", --tabCnt);
// };
// var data = {
//  "phone": "380978442044",
//  "exten": "500",
//  "texttospeach": "null"
// };

// $.ajax({
//  url:'http://office.krusher.biz:3001/originate',
//  type:"POST",
//  data:JSON.stringify(data),
//  contentType:"application/json; charset=utf-8",
//  dataType:"json",
//  success: () => {
//    console.log(`Done ORIGINATE`);
//  }
// });

// setTimeout(() => {
//     var top = ($(window).scrollTop() || $("body").scrollTop());

//     window.scrollTo(0,0);
//     console.log( 'Текущая прокрутка сверху: ' + window.pageYOffset );
//     console.log( 'Текущая прокрутка слева: ' + window.pageXOffset );
// var scrollTop = window.pageYOffset || document.documentElement.scrollTop;

// console.log( "Текущая прокрутка: " + scrollTop );
// }, 3000);
function PreLoader(){
              $preloader    = $('.loaderArea');
              $loader       = $preloader.find('.loader');
              $loader.fadeOut();
              $preloader.delay(350).fadeOut('slow');
}
$(window).on('load', () => {
          PreLoader();
});

function disableF5(e) { 
    if ((e.which || e.keyCode) == 116 || ((e.which || e.keyCode ) == 82 && e.ctrlKey) ) e.preventDefault(); 
}
$(document).on("keydown", disableF5);
// this code handles the  F5/Ctrl+F5/Ctrl+R

// Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
$.widget.bridge('uibutton', $.ui.button);