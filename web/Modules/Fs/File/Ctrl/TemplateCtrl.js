crmUA.controller('fsTemplateCtrl', function($scope, $timeout) {
    $scope.getTemplates = () => {
        new fsTemplatesSrv().getFind( {} ,cb    => { $scope.templates  = cb; $scope.$apply(); });
    };
    $scope.getTemplates();

    new fsTemplatesEncodingSrv().getAll( cb   => { $scope.encodings  = cb; $scope.$apply(); });

    $scope.getTemplate = id => {
        $scope.Template = null;
        $scope.id       = null;
        if ($scope.templates && id) {
            $scope.showNewBtn = $scope.templates.some( value => {
                if(value.ftID == id) {
                    $scope.Template = value;
                    $scope.id = id;
                    return value;
                }
            });
        }

        //Новый шаблон
        if(!$scope.Template || $scope.Template === undefined ) { $scope.Template = new fsTemplatesModel().put(); }

        if(id){
                //если редактировать шаблон
                new fsTemplatesItemsSrv().getFind({ ftID : id}, cb => { $scope.items = cb; $scope.$apply(); });
        }
        else{
                //Если новый шаблон
                $scope.items = [ {"ftType":45,"ColNumber":[1]} ];
        }
    };
    $scope.getTemplate();

    $scope.Check = a => {
        var input = false;
        angular.forEach($scope.items, todo => {
                if(todo.ftType == a) input = true;
        });
        return input;
    };

    //Добавляем позиции колонки
    $scope.addRow = () => {
        $scope.notSave = true;
        $scope.items.push(new fsTemplatesItemsModel('').get());
    };

    //Удаляем позиции колонки
    var delrow =[];
    $scope.delRow = a => {
        delrow.push($scope.items[a].ftiID);
        $scope.items.splice(a,1);
    };

    //Новый шаблон

    $scope.TemplateEdit = (template, value) =>{
        if(template.ftID === null||template.ftID === undefined){
            //Get new ID
            let ftID = template.ftID = lookUp(API.us.Sequence, 'ftID').seqValue;
            new fsTemplatesSrv().ins(template,() => {
                angular.forEach(value, row => {
                    row.ftID = ftID;
                    new fsTemplatesItemsSrv().ins(row);
                });
                $scope.getTemplates();
             });
        }else{
            new fsTemplatesSrv().upd(template, () => {
                $scope.getTemplates();
                angular.forEach(value, row => {
                    row.ftID = template.ftID;
                    if(row.ftiID!==undefined){
                        new fsTemplatesItemsSrv().upd(row);
                    }else{
                        new fsTemplatesItemsSrv().ins(row);
                    }
                });
            });
        }

        //Удаляем колонки
        angular.forEach(delrow, row => {
            if(row) new fsTemplatesItemsSrv().del(row);
        });

        $scope.Clear();
    };

    $scope.delTemplate = a => {
        new fsTemplatesSrv().del(a.ftID,() => {
            new fsTemplatesSrv().getAll( cb => { $scope.templates = cb; $scope.$apply(); });
            $scope.Clear();
            $scope.getTemplate();
        });
    };

    //Формируем масив с колонками
    $scope.Columns = item => {
        var columns     = item.ColNumber.split(",");
        item.ColNumber  = [];

        if(columns[0] != '' ) {

                if( (item.ftDelim === null || item.ftDelim == "" || item.ftDelim === undefined) && item.ftType != 60 && item.ftType != 57 && item.ftType != 61 && item.ftType != 62 && item.ftType != 63 && item.ftType != 64)

                angular.forEach(columns, todo => {
                //CONDITIONS
                if (todo) {
                    var num = parseInt(todo) || null;
                    if (num > 0 && num <= 50)
                        item.ColNumber.push(num);
                }
                else item.ColNumber.push(todo);
                });

            else {
                var num = parseInt(columns[0]) || null;
                if (num > 0 && num <= 50)
                item.ColNumber.push(num);
            }
        }
        if(item.ColNumber.length > 0)
            $scope.notSave = false;
        else
            $scope.notSave = true;
    };

    $scope.Clear = () => {
        delete $scope.items;
        delete $scope.Template;
        delete $scope.id;
        $scope.getTemplate();
    };

});
// && item.ftDelim !== null && item.ftType != 60 && item.ftType != 57 && item.ftType != 61 && item.ftType != 62 && item.ftType != 63 && item.ftType != 64