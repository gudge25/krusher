
crmUA.directive('globalButton', () => {
    return {
        link: (scope, element, attrs) => {
            scope.dirUrl = attrs.url;
        },
        templateUrl: `/Views/btnCustomLogic.html`,
    };
});
crmUA.directive('globalButton2', () => {
    return {
        link: (scope, element, attrs) => {
            scope.dirUrl = attrs.url;
        },
        templateUrl: `/Views/btnCustomLogic2.html`,
    };
});

crmUA.directive('hystoryLi', () => {
    return {
        transclude:true,
        link: (scope, element, attrs) => {
            scope.t = attrs.t;
            scope.n = attrs.n;
            scope.o = attrs.o;
            if(scope.o == `- Ответственные -`) scope.o = null;
            if(scope.n == `- Ответственные -`) scope.n = null;

        },
        templateUrl: `/Views/HystoryLi.html`,
    };
});



crmUA.directive('onReadFile', $parse => {
   return {
       restrict: 'A',
       scope: false,
       link: (scope, element, attrs) => {
           var fn = $parse(attrs.onReadFile);
           element.on('change', onChangeEvent => {
               var reader = new FileReader();
               reader.onload = onLoadEvent => {
                   scope.$apply( () => {
                       fn(scope, {$fileContent:onLoadEvent.target.result});
                   });
               };
               reader.readAsText((onChangeEvent.srcElement || onChangeEvent.target).files[0]);
           });
       }
   };
});

crmUA.directive('fileModel', ['$parse', $parse => {
   return {
       restrict: 'A',
       link: (scope, element, attrs) => {
           var model       = $parse(attrs.fileModel);
           var modelSetter = model.assign;
           element.bind('change', () =>{
               scope.$apply( () => {
                   modelSetter(scope, element[0].files[0]);
               });
           });
       }
   };
}]);

crmUA.directive('ngEnter', () => {
    return (scope, element, attrs) => {
        element.bind("keydown keypress", event => {
            if(event.which === 13) {
                scope.$apply( () => {
                    scope.$eval(attrs.ngEnter);
                });
                event.preventDefault();
            }
        });
    };
});

crmUA.directive('layer', $document =>{
    return (scope, element) => {
        element.bind('mouseenter', () => {
            $document.on("click", () => {
                element.children().eq(1).removeClass('hidden');
                element.children().eq(0).addClass('hidden');
            });
        });
        element.bind('mouseleave', () => {
            $document.on("click", () => {
                element.children().eq(0).removeClass('hidden');
                element.children().eq(1).addClass('hidden');
            });
        });
    };
});

crmUA.directive('blink', $timeout => {
        return {
            restrict    : 'E',
            transclude  : true,
            scope       : {},
            controller  : ($scope, $element,$attrs) => {
                            $scope.speed = $attrs.speed ? $attrs.speed : 1000;
                            $scope.promise;
                            $scope.blinking = true;
                            function showElement() {
                                $element.css("visibility", "visible");
                                $scope.promise = $timeout(hideElement,$scope.speed);
                            }
                            function hideElement() {
                                $element.css("visibility", "hidden");
                                $scope.promise =  $timeout(showElement,$scope.speed);
                            }
                            $scope.stop = () => {
                                $timeout.cancel($scope.promise);
                                if($scope.blinking){
                                    console.log("stopping the madness...");
                                    $element.css("visibility", "visible");
                                }else{
                                    console.log("starting the madness...");
                                    showElement();
                                }
                                $scope.blinking = !$scope.blinking;
                            };
                            showElement();
                         },
            template    : '<span ng-transclude></span>',
            replace     : true
        };
});




crmUA.directive('showErrors', $timeout => {
    return {
      restrict  : 'A',
      require   : '^form',
      link      : (scope, el, attrs, formCtrl) =>  {
                    // find the text box element, which has the 'name' attribute
                    var inputEl   = el[0].querySelector("[name]");
                    // convert the native text box element to an angular element
                    var inputNgEl = angular.element(inputEl);
                    // get the name on the text box
                    var inputName = inputNgEl.attr('name');

                    // only apply the has-error class after the user leaves the text box
                    var blurred = false;
                    inputNgEl.bind('blur', () => {
                      blurred = true;
                      el.toggleClass('has-error', formCtrl[inputName].$invalid);
                    });

                    scope.$watch( () => {
                      return formCtrl[inputName].$invalid;
                    }, invalid => {
                      // we only want to toggle the has-error class after the blur
                      // event or if the control becomes valid
                      if (!blurred && invalid) { return; }
                      el.toggleClass('has-error', invalid);
                    });

                    scope.$on('show-errors-check-validity', () => {
                      el.toggleClass('has-error', formCtrl[inputName].$invalid);
                    });

                    scope.$on('show-errors-reset', () => {
                      $timeout( () => {
                        el.removeClass('has-error');
                      }, 0, false);
                    });
                  }
    };
});

crmUA.directive('myDate', dateFilter => {
    return {
        restrict    : 'EAC',
        require     : '?ngModel',
        link        : (scope, element, attrs, ngModel) => {
                        ngModel.$parsers.push( viewValue => dateFilter(viewValue,'yyyy-MM-dd') );
                      }
    };
});
crmUA.directive('myDate2', dateFilter => {
    return {
        restrict    : 'EAC',
        require     : '?ngModel',
        link        : (scope, element, attrs, ngModel) => {
                        ngModel.$parsers.push( viewValue => dateFilter(viewValue,'yyyy-MM-dd') );
                      }
    };
});

crmUA.directive('datetimepickerNeutralTimezone', () => {
    return {
        restrict    : 'A',
        priority    : 1,
        require     : 'ngModel',
        link        : (scope, element, attrs, ctrl) => {
                        ctrl.$formatters.push( value => {
                            if(value) {
                                var date    = new Date(value);
                                date        = new Date(date.getTime() + (60000 * date.getTimezoneOffset()));
                                return date;
                            }
                        });
                     }
    };
});


crmUA.service('getPre', function (){
    var [preNumb,audio] = [null,[]];
    this.setNumb = val => {
        preNumb = val;
    };
    this.getNumb = () => preNumb;

    this.setAudio = (index,data) => {
        audio.push({[index] : data }) ;
    };
    this.getAudio = () => audio;
});

crmUA.service('serv', function(){
    var data = null;
    this.setData = val => {
        data = val;
    };
    this.getData = () => data;
});
crmUA.service('printForm', function(){
    var [data,products,Deal] = [null,null];
    this.setData = val => {
        data = val;
    };
    this.getData = () => data;

    this.setProducts = val => {
        products = val;
    };
    this.getProducts = () => products;

    this.setDeal = val => {
        Deal = val;
    };
    this.getDeal = () => Deal;
});

crmUA.directive('audioPlayer', function (ngAudio,getPre) {
        return {
            restrict    : 'E',
            scope       : {
                index: "@",
                source: "@"
            },
            controller  : ($scope, $element,$attrs,$timeout) => {
                    $scope.pre = null;
                    $scope.play = (src,index) => {
                        pre = getPre.getNumb();
                        $scope.audio = getPre.getAudio();
                        if ($scope.audio[index] === undefined || pre !== index || $scope.audio[index].id !== src) {
                            $scope.audio[index]          = {};
                            $scope.audio[index]          = ngAudio.load(src);
                            $scope.audio[index].progress = 0;
                        }
                        $scope.audio[index].play();

                        //console.log($scope.audio[index]);
                        if ( (pre || pre ==  0) && pre !== index) {
                            $scope.audio[pre] = {};
                            $scope.audio[pre].progress=1;
                            $scope.pre = pre;
                        }
                        getPre.setAudio(index,$scope.audio[index]);
                        getPre.setNumb(index);
                        $timeout(() => {
                                $scope.$apply();
                        },0);
                    };

                    $scope.time = (src,index) => {
                        pre = getPre.getNumb();
                        $scope.audio = getPre.getAudio();
                        if ($scope.audio[index] === undefined || pre !== index || $scope.audio[index].id !== src) {
                            $scope.audio[index]          = {};
                            $scope.audio[index]          = ngAudio.load(src);
                            $scope.audio[index].progress = 0;
                        }
                    };

                    $scope.pause = i => {
                        $scope.audio[i].pause();
                    };
                    $scope.stop = i => {
                        $scope.audio[i].restart();
                    };
                         },
            template    : ` <div ng-init='playFlag[index]=true;'>
                                <nobr>
                                    
                                    <div class="btn-group mb-2" uib-dropdown>
                                        <a href id="split-button" ng-show='playFlag[index] || audio[index].progress==1' ng-click="$event.stopPropagation(); play(source,index); playFlag[index]=false; playFlag[pre]=true;"><i class="fa fa-play-circle fa-lg" aria-hidden="true"></i></a>
                                        <a href id="split-button" ng-hide='playFlag[index] || audio[index].progress==1' ng-click="$event.stopPropagation(); pause(index); playFlag[index]=true"><i class="fa fa-pause-circle fa-lg" aria-hidden="true"></i></a>
                                        &nbsp;    
                                        <a id="single-button" href uib-dropdown-toggle>
                                            <i class="fa fa-cog"></i>
                                            <span class="caret"></span>
                                        </a>
                                        <div class="dropdown-menu  dropdown-menu-right" uib-dropdown-menu role="menu" aria-labelledby="split-button" style="width:300px;">
                                            <a class="dropdown-item" >
                                                                <a style="padding-left: 1rem ;" ng-click="$event.stopPropagation();stop(index); playFlag[index]=true" uib-tooltip="{{'stop' | translate}}">
                                                                        <i class="fa fa-stop-circle fa-lg" aria-hidden="true"></i>
                                                                </a>
                                                                <a ng-href='{{source}}' ng-if="source" style="padding: 0" download uib-tooltip="{{'download' | translate}} : {{source}}">
                                                                    <i class="fa fa-cloud-download-alt fa-lg" aria-hidden="true" style="color: #3c8dbc"></i>
                                                                </a>
                                                                <span>{{'time' | translate}}: {{audio[index].duration | trackTime}} / {{audio[index].currentTime | trackTime}} </span>
                                            </a>
                                            <a class="dropdown-item" ng-init='audio[index].progress=0'>
                                                    <input class='form-control' style='display: inline-block; padding: 0; height: 0;' type="range" min="0" max="100" step="1" ng-model="audio[index].progress" disabled/>
                                            </a>
                                         </div>
                                    </div>

                                </nobr>
                            </div>`,
                            // <div uib-dropdown ng-show="e.clID && e.dcStatusName == 'ANSWERED' " uib-tooltip="{{'action'| translate}}">
                            //         <a id="single-button" href="#" ng-click="$event.stopPropagation()" uib-dropdown-toggle  >
                            //             <i class="fa fa-user" ng-show="e.IsPerson"      uib-tooltip="{{e.IsPerson | Person}}" tooltip-placement="left"></i>
                            //             <i class="fa fa-building" ng-hide="e.IsPerson"  uib-tooltip="{{e.IsPerson | Person}}" tooltip-placement="left"></i>
                            //             <span ng-bind="e.clName"></span> <span class="caret"></span>
                            //         </a>
                            //         <div class="dropdown-menu" uib-dropdown-menu role="menu" aria-labelledby="split-button">
                            //             <a class="dropdown-item" ng-show="e.clID" href="#!/clientPreView/{{e.clID}}"  >{{'open'| translate}}</a>
                            //             <a class="dropdown-item" ng-click="$event.stopPropagation()"><create-deal data="{{e}}" ></create-deal></a>
                            //             <a class="dropdown-item" ng-click="$event.stopPropagation()"><create-form data="{{e}}" ></create-form></a>
                            //             <a class="dropdown-item" ng-click="$event.stopPropagation()"><edit-callingcard data="{{e}}" ></edit-callingcard></a>
                            //         </div>
                            //     </div>

            replace     : true
        };

});
crmUA.directive('showComments', function () {
        return {
            restrict    : 'E',
            controller  : 'TapeCommCtr',
            templateUrl   :`${Gulp}Tape/Views/TapeCommView.html`
        };

});
crmUA.directive('dealStatistic', function ($stateParams,serv) {
            return {
                restrict    : 'E',
                transclude  : true,
                controller  :'DealStatCtrl',
                template : `
                    <div ng-hide="hideGraph">
                        <div class="col-md-4 col-md-offset-1" style="margin: 10px 0" >
                            <ui-select ng-model="dcTVID.tvID" theme="bootstrap4-1" class="normal" size="100%" ng-change="getDealProd()">
                                <ui-select-match placeholder="{{'selectStatus' | translate}}">{{$select.selected.NameT}}</ui-select-match>
                                <ui-select-choices repeat="a.tvID as a in docsStatus| filter: $select.search" >
                                   {{a.NameT}}
                            </ui-select-choices>
                        </div>
                        <div ><!-- style="margin-top: 30px" ng-class="{'col-md-8 col-md-offset-1' : fullWidth == true}" -->
                            <highchart  config="chartConfig" ></highchart>
                        </div>
                    </div>
                `
            };
});