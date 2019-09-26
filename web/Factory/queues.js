class FactQueues extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astQueueSrv().getFind(this.model,x => {
        	this.result.data = x; //if(this.result.data.length > 0) this.result.data.unshift( {queID: null, name: "- Очереди -", isActive:true});
        	this.modelItem		= this.model;
        	this.modelItem.emID 	= EMID;
            new astQueueMemberSrv().getFind(this.modelItem,cb => {
                this.result.myQueues    = [];
		        if(cb.length > 0){
                            this.result.data.forEach( e2 => {
                                cb.forEach( e => {
                                    if(e2.queID && e.queID)
                                        if(e.queID == e2.queID ) {  if( this.result.myQueues.findIndex(x => x.queID === e.queID) == -1 ) this.result.myQueues.push(e); }
                                });
                            });
                }
		    });
    	});
    }
}
const FactQueuesRun = new FactQueues();