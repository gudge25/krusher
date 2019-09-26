crmUA.directive('lowercase', function () {
    return {
        require: 'ngModel',
        link: function ($scope, elem, attrs, ngModelCtrl) {
            var lowercase = function (inputValue) {
                if(inputValue === undefined) inputValue = '';

                var lowercased = inputValue.toLowerCase();

                if(lowercased !== inputValue) {
                    ngModelCtrl.$setViewValue(lowercased);
                    ngModelCtrl.$render();
                }
                return lowercased;
            };
            ngModelCtrl.$parsers.unshift(lowercase);
            lowercase($scope[attrs.ngModel]);
        }
    };
});

crmUA.directive('uppercase', () => {
    return {
        restrict: "A",
        require: "?ngModel",
        link: (scope, element, attrs, ngModel) => {
                var el = element[0];
            //This part of the code manipulates the model
                ngModel.$parsers.push( input => {
                        if(input) {
                            let transformedInput = input.toUpperCase().replace(/\s{2,}/g, ' ').replace(/\s*,/g, ',').replace(/,(?=[^\s])/g, ', ').replace(/\s*\.\s*/g, '.');
                            let space = 0;  let space2 = 0;
                            if(input.search(/\s{2,}/g) >= 0 )   space = 1;
                            if(input.search(/\.\s/g) >= 0)      space = 1;
                            if(input.search(/\s\./g) >= 0)      space = 1;
                            if(input.search(/,(?=[^\s])/g) >= 0) { space = -1; space2 = 1;}

                            var start = el.selectionStart + space2;
                            var end = el.selectionEnd - space;
                            ngModel.$setViewValue(transformedInput);
                            ngModel.$render();

                            el.setSelectionRange(start, end);
                            return transformedInput;
                        }
                });
            element.css("text-transform","uppercase");
        }
    };
});

crmUA.directive('numericOnly', () => {
    return {
        require : 'ngModel',
        link    : (scope, element, attrs, modelCtrl) => {

                    scope.$watch(attrs.ngModel, v => {
                        if(v){
                            //Check if Float and not render
                            if( v <= 0) v = 0;

                            // console.log(attrs.ngModel);
                            if(attrs.ngModel.includes(`volume`) || attrs.ngModel.includes(`retries`) || attrs.ngModel.includes(`retry`) )
                                    if(  v >= 10) v = 10;

                            if(attrs.ngModel.includes(`timeout`) || attrs.ngModel.includes(`timeoutrestart`) || attrs.ngModel.includes(`wrapuptime`))
                                    if(  v >= 600) v = 600;

                            if(attrs.ngModel.includes(`percent`))
                                    if(  v >= 100) v = 100;

                            if(attrs.ngModel.includes(`DayNumFinish`) || attrs.ngModel.includes(`DayNumStart`))
                                    if(  v >= 31) v = 31;

                            if(attrs.ngModel.includes(`RecallDaysCount`) ){
                                    if(  v >= 365)   v = 365;
                                    if(  v <= 0)     v = 1;
                            }

                            if(attrs.ngModel.includes(`RecallAfterPeriod`) ){
                                    if(  v >= 100)   v = 100;
                                    if(  v <= 0)     v = 1;
                            }

                            if(attrs.ngModel.includes(`RecallCountPerDay`) || attrs.ngModel.includes(`lines`)){
                                    if(  v >= 1000)  v = 1000;
                                    if(  v <= 0)     v = 1;
                            }

                            if(attrs.ngModel.includes(`port`)){
                                    if(  v >= 65535) v = 65535;
                                    if(  v <= 0)     v = 1;
                            }

                            if(attrs.ngModel.includes(`priority`)){
                                    if(  v >= 1000)  v = 1000;
                                    if(  v <= 0)     v = 1;
                            }
                            
                            if (v) {
                                modelCtrl.$setViewValue(parseInt(v));
                                modelCtrl.$render();
                            }
                            return parseInt(v);
                        }
                    });

                    //Finish edit
                    modelCtrl.$parsers.push( inputValue => {
                        inputValue = inputValue.toString();
                        var transformedInput ;
                        transformedInput = inputValue ? inputValue.replace(/[^0-9]/g,'') : null; //replace(/[^\d.-]/g,'')
                        if(transformedInput !== '') transformedInput = parseInt(transformedInput);

                        //Check if Float and not render
                        if(isFloat(transformedInput) || transformedInput <= 0 || transformedInput >= 100000000000000) transformedInput = 0;
                        if (isInteger(transformedInput)) {
                            modelCtrl.$setViewValue(parseInt(transformedInput));
                            modelCtrl.$render();
                        }
                        return parseInt(transformedInput);
                    });
                 }
    };
});

crmUA.directive('latOnly', () => {
    return {
        require : 'ngModel',
        link    : (scope, element, attrs, modelCtrl) => {
                    modelCtrl.$parsers.push( inputValue => {
                        var transformedInput = inputValue ? inputValue.replace(/[^\D.-]/g,'').replace(/\s\s+/g, ' ') : null;
                        if (transformedInput!=inputValue) {
                            modelCtrl.$setViewValue(transformedInput);
                            modelCtrl.$render();
                        }
                        return transformedInput;
                    });
                  }
    };
});
crmUA.directive('latOnlyEn', () => {
    return {
        require : 'ngModel',
        link    : (scope, element, attrs, modelCtrl) => {
                    modelCtrl.$parsers.push( inputValue => {
                        var transformedInput = inputValue ? inputValue.replace(/[^A-Za-z.-]/g,'').replace(/\s\s+/g, ' ') : null;
                        if (transformedInput!=inputValue) {
                            modelCtrl.$setViewValue(transformedInput);
                            modelCtrl.$render();
                        }
                        return transformedInput;
                    });
                  }
    };
});

crmUA.directive('onlyClear', () => {
    return {
        require : 'ngModel',
        link    : (scope, element, attrs, modelCtrl) => {
                    modelCtrl.$parsers.push( inputValue => {
                        //console.log(inputValue);
                        var transformedInput = inputValue ? inputValue.replace(/[^A-Za-zА-Яа-яіІїЇЁёєЄ0-9.-\s_]/g,'').replace(/\s\s+/g, ' ') : null;
                        //console.log(transformedInput);

                        if (transformedInput!=inputValue) {
                            modelCtrl.$setViewValue(transformedInput);
                            modelCtrl.$render();
                        }
                        return transformedInput;
                    });
                  }
    };
});

crmUA.directive('onlyCalendar', () => {
    return {
        require : 'ngModel',
        link    : (scope, element, attrs, modelCtrl) => {
                    modelCtrl.$parsers.push( inputValue => {
                        //console.log(inputValue);
                        console.log(inputValue)
                        var transformedInput = inputValue ? inputValue.replace(/[^0-9:-\s_]/g,'').replace(/\s\s+/g, ' ') : null;
                        //console.log(transformedInput);
                        console.log(transformedInput)
                        if (transformedInput!=inputValue) {
                            modelCtrl.$setViewValue(transformedInput);
                            modelCtrl.$render();
                        }
                        return transformedInput;
                    });
                  }
    };
});