class FactEm extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        this.model.isActive = null;
        this.model.sorting = `ASC`;
        this.model.field = `emName`;
        new emEmployeeSrv().getFind(this.model,x => { 
            this.result.data = x.filter( x => x.isActive);
            this.result.dataAll = x;
            this.result.group = _.groupBy(x, 'ManageID');

            if(EMID){
                //Supervizors USER
                if(this.result.group[EMID]) {
                            //get yourself
                            let d = this.result.data.filter( x => x.emID == EMID);
                            //add yourself
                            if(this.result.group[EMID].findIndex(x => x.emID === EMID) == -1 ) this.result.group[EMID].push(d[0]);
                }
                //Supervizor
                if(this.result.group[null]) {
                            let d = this.result.group[null].filter( x => x.roleID == 2 );  this.result.group.supervizor = d;
                }
            }

        });  //,cb => { this.data.data = cb;}
    }
}
const FactEmRun = new FactEm();