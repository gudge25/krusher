'use strict';
module.exports.create = function (options) {
    if (!options)
        return {};
    options.lastPage = Math.ceil(options.totalCount / options.perPage);
    const pagination = new Pagination(options);
    const pagesLinkBuilder = new PagesLinkBuilder(options);
    if (pagination.hasMoreData()) {
        if (pagination.isAfterFirst()) {
            pagesLinkBuilder.setFirstPage();
            pagesLinkBuilder.setPrevPage();
        }
        if (pagination.isBeforeLast()) {
            pagesLinkBuilder.setNextPage();
            pagesLinkBuilder.setLastPage();
        }
    }
    return pagesLinkBuilder.links;
};
function Pagination(options) {
    this.options = options;
}
;
Pagination.prototype = (() => {
    return {
        hasMoreData() {
            return this.options.totalCount > this.options.perPage;
        },
        isBeforeLast() {
            return this.options.page < this.options.lastPage;
        },
        isAfterFirst() {
            return this.options.page > 1;
        },
        getOptions() {
            return this.options;
        },
        getLastPage() {
            return this.options.lastPage;
        }
    };
})();
function PagesLinkBuilder(options) {
    this.options = options;
    this.links = {};
}
;
PagesLinkBuilder.prototype = (() => {
    const buildLink = function (url, page, perPage) {
        return `${ url }?page=${ page }&per_page=${ perPage }`;
    };
    return {
        setFirstPage() {
            this.links.first = buildLink(this.options.url, 1, this.options.perPage);
        },
        setNextPage() {
            this.links.next = buildLink(this.options.url, this.options.page + 1, this.options.perPage);
        },
        setPrevPage() {
            this.links.prev = buildLink(this.options.url, this.options.page - 1, this.options.perPage);
        },
        setLastPage() {
            this.links.last = buildLink(this.options.url, this.options.lastPage, this.options.perPage);
        },
        getLinks() {
            return this.links;
        }
    };
})();