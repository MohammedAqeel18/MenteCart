const requiredEnvVariables = [
    "PORT",
    "MONGO_URI",
    "JWT_SECRET",
];

requiredEnvVariables.forEach((key)=>{
    if(!process.env[key]){
        throw new Error(
            `Missing environment variable: ${key}`
        );
    }
});

