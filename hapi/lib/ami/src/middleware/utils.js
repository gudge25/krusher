var module = exports;
 
module.clearnum = a => {
      if(a){
            //Bug when num with +
            let cn = a.toString();
            cn = cn.replace(/\D/g, "");
            if (cn.length == 7 && cn.substring(0,1) != 0) cn = `044${cn}`;
            if (cn.length == 9 && cn.substring(0,1) != 0) cn = `380${cn}`;
            if (cn.length == 10 && cn.substring(0,1) == 0) cn = `38${cn}`;
            //ru
            if (cn.length == 10 && cn.substring(0,1) != 0) cn = `7${cn}`;
            if (cn.length == 11 && cn.substring(0,1) == 8) cn = `7${cn.substr(cn.length - 10)}`;
            return cn;
      }
};

module.source  = chan => {
      if(chan){
            //Clear chanel and convert to source
            let a   = chan        ? chan.split("/")[1] : null;
            a       = a ? a.split("-")[0] : null;
            return a ? a.split("_")[0] : null;
      }
};

module.sip = chan => {
      if(chan){
            //Clear chanel and convert to source
            let a   = chan  ? chan.split("/")[1] : null;
            a       = a     ? a.split("-")[0] : null;
            return a ? a : null;
      }
};