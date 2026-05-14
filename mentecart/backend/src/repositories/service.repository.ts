import {Service} from "../models/service.model";

interface GetServicesParams {
    page: number;
    limit: number;
    category?: string;
    search?: string;
}

export const getServicesRepository = async({
    page,
    limit,
    category,
    search,

}: GetServicesParams) => {
    const query: any = {};

    if (category){
        query.category = category;
    }

    if(search){
        query.title = {
            $regex: search,
            $options: "i",
        };
    }

    const skip = (page - 1) * limit;

    const services = await Service.find(query)
    .skip(skip)
    .limit(limit);

    const total = await Service.countDocuments(query);

    return {
        services,
        total,
    };
};

export const getServiceByIdRepository = async(
    id: string
)=> {
    return Service.findById(id);
};