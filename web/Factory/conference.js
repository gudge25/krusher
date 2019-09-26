class FactConference extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new astConferenceSrv().getFind(this.model,x => { this.result.data = x; });
    }
}
const FactConferenceRun = new FactConference();