class BaseService {
        constructor(api, Model, idName) {
            [ this.Api, this.Model, this.IdName ] = [ api, Model, idName ];
        }


        /* NEW async method */
        getAll(cb){
            var ModelGet = this.Model;
            return  $.ajax({
                url: this.Api,
                success: cb,
                dataFilter(data) { return dataFilterModel(data,ModelGet); }
            });
        }

        get(id,cb){
            var ModelGet = this.Model;
            return $.ajax({
                url: `${this.Api}${id}`,
                success: cb,
                dataFilter(data) { return dataFilterModel(data,ModelGet); }
            });
        }

        ins(data,url,cb){
            //var ModelGet    = this.Model;
            //var obj         = new this.Model(data).post();
            var obj = data;
            return  $.ajax({
                type: 'POST',
                url: `${this.Api}${url}`,
                success: cb,
                data: JSON.stringify(obj),
                dataFilter(data) { return dataFilterModel(data,ModelGet); }
            });
        }

        upd(data,cb){
            //var arr = new this.Model.put(data);
            var arr = new this.Model(data).put();
            if(this.IdName in arr) var route = arr[this.IdName]; else var route = data[this.IdName];
            if(route == undefined) route = arr[this.IdName];
            return  $.ajax({
                type: 'PUT',
                url: this.Api + '/' + route,
                success: cb,
                data: JSON.stringify(arr)
            });
        }

        del(id,cb){
            return  $.ajax({
                type: 'DELETE',
                url: this.Api + '/' + id,
                success: cb
            });
        }
}
