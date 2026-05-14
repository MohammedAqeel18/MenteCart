import {
    getServiceByIdRepository,
    getServicesRepository,
} from "../repositories/service.repository";

export const getAllServices = async (
    page:number,
    limit: number,
    category?: string,
    search?: string
) => {

    const {services, total }= 
    await getServicesRepository({
        page,
        limit,
        category,
        search,
    });

    return {
        services,
        pagination: {
            total,
            page,
            limit,
            hasMore : total > page * limit,
        },
    };
};

export const getSingleService = async(
    id: string
) => {
    const service = 

    await getServiceByIdRepository(id);

    if(!service){
        throw new Error("Service not found");
    }

    return service;
};

