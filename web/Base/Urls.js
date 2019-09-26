//NEW HAPI
const h = `/api/`;

const portWS 	= window.location.port ? parseInt(window.location.port)+1 	: 91;

const API = {
// "NBR":{
// 	"simple" :"http://vpn.unbr.com:88/functions/companyinfo",
// 	"full2short" :"http://vpn.unbr.com:88/functions/full2short",
// 	"morpher" :"http://vpn.unbr.com:88/functions/morpher",
// 	"ErrorCheck" :"http://vpn.unbr.com:88/functions/errorscheck"
// },
"sms" : {
	"GoipIncoming": `${h}sms/goip/incoming`,
	"Single": `${h}sms/outgoing/single`,
	"Bulk": `${h}sms/outgoing/bulk` 
},
"hooks": `//chat.asterisk.biz.ua/hooks/gFKaeZuML4a4wsbRo/9fKqqEs6327rfZvvk2EeMEj5KsTBjw6ztYSsDTnNbBpuALPc`,
"customPhp":`${h}ast/update`,
"ws": `ws://${window.location.hostname}:${portWS}`,
"wss": `wss://${window.location.hostname}:${portWS}`,
"fsFiles": `${h}fs/files/10/1`,
"History": {
	"Client" : `${h}h/client/find`,
	"Em" : `${h}h/employ/find`,
},
"mp" :{
	"Marketplace": `${h}mp/marketplace/list`,
	"MarketplaceInstall": `${h}mp/marketplace/install`,
},
"ast" : {
	"Queue": `${h}ast/queues`,
	"QueueMember": `${h}ast/queues/members`,
	"Sippeers": `${h}ast/sippeers`,
	"Trunk": `${h}ast/trunks`,
	"RouteInc": `${h}ast/route/incoming`,
	"Scenario":`${h}ast/scenario`,
	"AutoProcess":`${h}ast/autodial/process`,
	"IVRConfig":`${h}ast/ivr`,
	"IVREntry":`${h}ast/ivr/items`,
	"Record":`${h}ast/records`,
	"RouteOut": `${h}ast/route/outgoing`,
	"RouteOutItems": `${h}ast/route/outgoing/items`,
	"TTS" : `${h}ast/tts`,
	"TTSFields" : `${h}ast/tts/fields`,
	"TrunkPool": `${h}ast/pools`,
	"TrunkPoolList": `${h}ast/pool/items`,
	"CustomDestenation": `${h}ast/custom/destination`,
	"TimeGroup": `${h}ast/time/group`,
	"TimeGroupItems": `${h}ast/time/group/items`,
	"CallBack": `${h}ast/callback`,
	"Conference": `${h}ast/conference`,
	"Recall": `${h}ast/recall`,
},
"reg": {
	"regions": `${h}reg/regions`,
	"gmt": `${h}reg/gmt`,
	"operators": `${h}reg/operators`,
	"countries": `${h}reg/countries`,
	"Phone": `${h}reg/regions/phone`,
	"Areas": `${h}reg/areas`,
	"Validation": `${h}reg/validation`,
	"Location": `${h}reg/locations`,
},
"fs": {
	"Templates": `${h}crm/templates`,
	"TemplatesItems": `${h}crm/templates/items`,
	"Files": `${h}crm/files`,
	"Encodings": `${h}crm/templates/encodings`,
	"Detail": `${h}crm/files/detail`,
	"Bases": `${h}crm/bases`,
	"BasesSaBD": `${h}crm/bases/sabd`,
	"BasesLookup": `${h}crm/bases/lookup`,
	"Export": `${h}crm/files/export`,
	"UpdStatus": `${h}crm/files/updstatus`,
	"FilesClear": `${h}crm/files/clear`
},
"fm":{
	"Questions": `${h}dc/questions`,
	"QuestionItems": `${h}dc/questions/items`,
	"Forms": `${h}dc/forms`,
	"FormItems": `${h}dc/forms/items`,
	"FormTypes": `${h}dc/formtypes`,
	"FormTypesLookup": `${h}dc/formtypes/lookup`,
	"QuestionReport": `${h}dc/questions/report`,
	"QuestionItemsReport": `${h}dc/questions/items/report`,
	"Export": `${h}dc/forms/export`
},
"crm": {
	"Client": {
		"All": `${h}crm/clients`,
		"Find": `${h}crm/clients/find`,
		"Summary": `${h}crm/clients/summary`,
		"Ex": `${h}crm/clients/ex`,
		"ExList": `${h}crm/clients/ex/list`,
		"Search" : `${h}crm/clients/search`,
		"Tag" : `${h}crm/tags`,
		"TagList" : `${h}crm/taglist`,
		"Stream" : `${h}crm/clients/stream`,
		"Parent": `${h}crm/clients/parent`,
		"Actualize" : `${h}crm/clients/actualize`,
		"SaBD": `${h}crm/clients/sabd`
	},
	"Company":`${h}crm/company`,
	"Contact": `${h}crm/contacts`,
	"Responsible": {
		"Responsible": `${h}crm/responsible`,
		"List" : `${h}crm/responsible/list`,
		"SaBD": `${h}crm/responsible/sabd`,
	},
	"status": `${h}crm/status`,
	"Person" : `${h}crm/persons`,
	"Address": `${h}crm/address`,
	"org": `${h}crm/orgs`,
	"Product": `${h}crm/products`,
},
"em": {
	"Employee": {
		"All": `${h}em/employees`,
		"Stat": `${h}em/employees/stat`,
		"Private": `${h}em/employees/private`,
		"Role": `${h}em/roles`,
		"Ex": `${h}em/employees/ex`,
		// "Calls": `${h}em/employees/report/calls`,
		// "Status": `${h}em/employees/report/status`,
		"Clients": `${h}em/clients`,
		"NewStatus":`${h}em/employees/status/stat`,
		"Сounter":`${h}em/employees/counter`,
		"Status":`${h}em/employees/status`
 	},
	"Password": `${h}em/password`
},
"us": {
	"Enums": `${h}us/enums`,
	"Sequence": `${h}us/sequence/next`,
	"Comment" : `${h}us/comments`,
	"MeasuresLookup": `${h}us/measures/lookup`,
	"Measures": `${h}us/measures`,
	"Rank": `${h}us/rank`
},
"cc": {
	"Comment": `${h}cc/comments`,
	"CommentList": `${h}cc/comments/list`,
	"Contact": `${h}cc/contacts`,
	"Billing": `${h}cc/contacts/billing`,
	"DailyReport": `${h}cc/contacts/report/daily/hours`,
	"DailyReportExport": `${h}cc/contacts/report/daily/hours/export`,
	"DailyCalls": `${h}cc/contacts/report/daily/calls`,
	"DailyCallsExport": `${h}cc/contacts/report/daily/calls/export`,
	"DailyStatuses": `${h}cc/contacts/report/daily/statuses`,
	"DailyStatusesExport": `${h}cc/contacts/report/daily/statuses/export`,
 	"ContactDashboard":`${h}cc/contacts/dashboard`,
	"Export":`${h}cc/contacts/export`,
	"Analize1":`${h}cc/contacts/report/daily/analyse1`,
	"Analize1Export": `${h}cc/contacts/report/daily/analyse1/export`,
	"Records": `${h}cc/contacts/export/records`,
	"Missed": `${h}cc/contacts/missed`,
},
"dc": {
	"Doc": `${h}dc/docs`,
	"Docs": `${h}dc/docs/clients`,
	"DocsTypes": `${h}dc/types`,
	"Stream" : `${h}dc/docs/stream`,
	"DocsSearch": `${h}dc/docs/find`,
	"DocsHistory": `${h}dc/docs/history`,
	"Templates": `${h}dc/templates`,
	"TemplatesLookup": `${h}dc/templates/lookup`
},
"st": {
	"Products": `${h}dc/products`,
	"ProductFind": `${h}dc/products/find`,
	"Categories": `${h}dc/categories`,
	"Brands": `${h}dc/brands`
},
"sl": {
	"Deal": `${h}dc/deals`,
	"DealItems": `${h}dc/deals/items`,
	"DealChart": `${h}dc/deals/chart`
},
"ga":{
	"Car": `${h}ga/cars`,
	"Driver": `${h}ga/drivers`,
	"Point": `${h}ga/points`,
	"Travellist": `${h}ga/travellists`,
	"Travel": `${h}ga/travels`
},
"sf":{
	"Invoice": `${h}dc/invoices`,
	"InvoiceItems": `${h}dc/invoices/items`
},
"pch":{
	"Payment": `${h}dc/payments`
},
"Completion":`${h}Completion`,
"Contract":`${h}Contract`,
"Favorites":`${h}us/favorites`
};