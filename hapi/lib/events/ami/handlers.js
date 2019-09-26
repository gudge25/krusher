'use strict';
const Request = require('./middleware/Request');

const externals = {};

externals.sourceHandler = (lim, ffID, uri, callback) => {
    const self = this;
    const body = { ffID, lim };
    const options = {
        uri,
        method: 'POST',
        json: true,
        body
    };
    Request(options, (error, payload) => {
        if (error) {
            const evt = {
                event: 'err',
                data: error
            };
            self.send(evt);
            return -1;
        }
        const data = [];
        payload.forEach((entry) => {

            const ent = {
                clID: entry.clID,
                phone: entry.phone,
                clName: entry.clName
            };
            data.push(ent);
        });
        // return callback(error, null);
        return callback(error, data);
    });
};

externals.resultHandler = (err, data) => {
    const self = this;
    self.isProgress = false;
    if (err) return self.sendError(err);

    data.event = 'progress-end';
    self.send(data);
};


externals.bridgeHeadler = evt => {
    sourceList.forEach((entry, index) => {
        if (evt.callerid2 === entry.phone && evt.bridgestate === 'Link') {
            bridgeList.push(entry);
            sourceList[index].isBridge = true;
            // Проверяем чтобы кол. соединений не превышало кол. сипов
            if (bridgeList.length >= qty) {
                self.action.hangup(sourceList);
            }
        }
    });
};

externals.hangupHeadler = evt => {
    const n = this.sourceList.length;
    for (let i = 0; i <= n; ++i) {
        if (evt.calleridnum === this.sourceList[i].phone) {
            hangupList.push(this.sourceList[i]);
            if (hangupList.length === sourceList.length) {
                const data = {
                    bridgeList,
                    exten
                };
                self.ami.removeListener('bridge', bridgeHeadler);
                self.ami.removeListener('hangup', hangupHeadler);
                resultHandler(null, data);
            }
        }
    }
};
module.exports = externals;