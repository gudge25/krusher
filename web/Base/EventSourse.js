// const eventSource = new EventSource('http://148.251.194.150:3000/events',{ withCredentials: true });
// var create = [];

// eventSource.addEventListener('api', evt => {
//     let data = JSON.parse(evt.data);
//     console.log(data.data );
//     switch(data.event){
//       case "ping"   : { break;}
//       case "create" : { create.push(data.data.route); break;}
//       case "update" : { break;}
//       case "delete" : { break;}
//       default       : { break;}
//     }
//     // console.log(create);
// });
