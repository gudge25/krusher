class hooksModel{
    constructor(p) {
        p = p ? p : {};
        this.p = p;
        this.username           = p.username            ?   p.username.toString()       : null;
        this.text               = p.text                ?   p.text.toString()           : null;
        this.attachments        = p.attachments         ?   p.attachments               : [];
    }

    get(){
        let  p = this.p; delete this.p;
        return this;
    }

    post(){
        let p = this.p; delete this.p;
        //this.id       = `gFKaeZuML4a4wsbRo/9fKqqEs6327rfZvvk2EeMEj5KsTBjw6ztYSsDTnNbBpuALPc` ;
        return this;
    }
 
}