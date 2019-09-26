class FormType extends BaseFactory {
    constructor(){
        super();
    }

    get name(){
        return this.result;
    }

    set name(a){
        new fmFormTypesSrv().getFind(this.model,x => { 
            this.result.data = x; 
        
        });
    }
}
const FormTypeRun = new FormType();