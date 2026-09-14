class ApiFeatures {
    constructor(mongooseQuery, queryString){
        this.mongooseQuery = mongooseQuery;
        this.queryString = queryString;
    }

    filter(){
        const queryObj = {...this.queryString};
        const excludedFields = ['page','limit','sort','fields'];
        excludedFields.forEach(el => delete queryObj[el]);
        this.mongooseQuery = this.mongooseQuery.find(queryObj);
        return this;
    }

    sort(){
        if(this.queryString.sort){
            const sortBy = this.queryString.sort.split(',').join(' ');
            this.mongooseQuery = this.mongooseQuery.sort(sortBy);
        }else{
            this.mongooseQuery = this.mongooseQuery.sort('-createdAt');
        }
        return this;
    }

    limitFields(){
        if(this.queryString.fields){
            const fields = this.queryString.fields.split(',').join(' ');
            this.mongooseQuery = this.mongooseQuery.select(fields);
        }
        return this;
    }

    paginate(countDoc){
        const page = this.queryString.page * 1 || 1;
        const limit = this.queryString.limit * 1 || 10;
        const skip = (page - 1) * limit;
        const endIndex = page * limit;
        const pagination = {}
        if(endIndex < countDoc){
            pagination.next = {
                page: page + 1,
                limit
            }
        }
        if(skip > 0){
            pagination.prev = {
                page: page - 1,
                limit
            }
        }
        this.mongooseQuery = this.mongooseQuery.skip(skip).limit(limit);
        return this;
    }

    search(){
        if(this.queryString.search){
            const search = this.queryString.search;
            this.mongooseQuery = this.mongooseQuery.find({
                $or: [
                    { title: { $regex: search, $options: 'i' } },
                    { description: { $regex: search, $options: 'i' } },
                ],
            });
        }
        return this;
    }
}

module.exports = ApiFeatures;