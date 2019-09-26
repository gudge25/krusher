class MenuViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,AclService)
    {
        super($scope,$filter,'', $translate,AclService);
		this.AclService = AclService;
    }

    Mod(){
		let tariff  = this.scope.auth.FFF.hosting_type;
		switch(tariff){
			case 101714:
			case 101713:
			case 101712:
			case 101711:
			case 101710: { TRIFF = this.scope.MOD = `AST`; break; }
			default:  { TRIFF = this.scope.MOD = `KRUS`;  break; }
		}
	}
	
    ACL(){
	    let AuthData  = this.scope.auth;
			
			this.ACLRoles();
			const [a,b,c,d,e,g] = ['Admin','Supervisor','Operator','Developer','Client','Validator'];
	        this.AclService.addResource('Menu')
	                  .addResource('DashBoard')
	                  .addResource('CallingCard')
	                  .addResource('Client')
	                  .addResource('Deal')
	                  .addResource('Form')
	                  .addResource('EditForm')
	                  .addResource('Template')
	                  .addResource('DcHistory')
	                  .addResource('Dc')
	                  .addResource('Settings')
	                  .addResource('Base')
	                  .addResource('ClientHistory')
	                  .addResource('Stream')
	                  .addResource('Api')
	                  .addResource('Search')
	                  .addResource('Ast')
	                  .addResource('Queue')
	                  .addResource('Trunk')
	                  .addResource('Report')
	                  .addResource('EM')
	                  .addResource('chief')
	                  .addResource('FOP2')
					  				.addResource('HotCreate')
					  				.addResource('Auto')
					  				.addResource('Role')
					//Role Admin
					  .allow(a, 'Auto', 'view')
						.allow(a, 'Settings', 'view')
	          .allow(a, 'EditForm', 'view')
	          .allow(a, 'Template', 'view')
	          .allow(a, 'Base', 'view')
	          .allow(a, 'Api', 'view')
	          .allow(a, 'Ast', 'view')
	          .allow(a, 'Queue', 'view')
	          .allow(a, 'Trunk', 'view')
	          .allow(a, 'EM', 'edit')
	          .allow(a, 'chief', 'edit')
					  .allow(a, 'FOP2', 'view')
					  .allow(a, 'HotCreate', 'view')
					  .allow(c, 'Client', 'view')
					  .allow(a, 'Role', 'edit')

					//Role Supervizor
					  .allow(b, 'EM', 'edit')
					  .allow(b, 'FOP2', 'view')
						.allow(b, 'Auto', 'view')

					//Role Validator
					  .allow(g, 'EM', 'edit')
					  .allow(g, 'FOP2', 'view')
 					  .allow(g, 'Auto', 'view')

	        //Role Operator  
						.allow(c, 'Menu', 'view')
						.allow(c, 'DashBoard', 'view')
						.allow(c, 'CallingCard', 'view')
						.allow(c, 'Deal', 'view')
						.allow(c, 'Form', 'view')
						.allow(c, 'DcHistory', 'view')
						.allow(c, 'Dc', 'view')
						.allow(c, 'ClientHistory', 'view')
						.allow(c, 'Search', 'view')
					  .allow(c, 'Report', 'view')
					  
					//Role Client
					  .allow(e, 'CallingCard', 'view')
					  .allow(e, 'DashBoard', 'view')
					  .allow(e, 'Form', 'view')
					  .allow(e, 'Deal', 'view')
					  .allow(e, 'EM', 'edit')
					  .allow(e, 'FOP2', 'view');

	        let user = AuthData.FFF;
 	        if(user){
		        switch(user.roleName){
		          case `Admin`      : { user.getRoles  = () => [a]; break; }
		          case `Supervisor` : { user.getRoles  = () => [b]; break; }
		          case `Operator`   : { user.getRoles  = () => [c]; break; }
				  		case `Developer`  : { user.getRoles  = () => [d]; break; }
							case `Client`  		: { user.getRoles  = () => [e]; break; }
							case `Validator`	: { user.getRoles  = () => [g]; break; }	
		          default : { console.log(`No role!!!`); break ;}
				}
 		        this.AclService.setUserIdentity(user);
 		        //CAN
 		        this.scope.can = this.AclService.can;
			 }
	}
}
