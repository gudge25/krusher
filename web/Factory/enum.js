class FactEnum extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        this.model.sorting  = `ASC`;
        this.model.field    = `tvID`;
        new usEnumsSrv().getFind(this.model,x => {
			this.result.data = x.filter( x => x.tvID != 101406 && x.tvID != 101315 && x.tvID != 101313 && x.tvID != 101314 ); //x.filter( x => x.tvID != 101406 && x.tvID != 101315 && x.tvID != 101313 && x.tvID != 101314 && x.tvID != 101312 );   
			this.result.group = _.groupBy(this.result.data, 'tyID'); });
    }
}
const FactEnumRun = new FactEnum();