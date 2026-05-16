import pinoHttp from "pino-http";

import { v4 as uuidv4 } from "uuid";

import logger from "../utils/logger";

const loggerMiddleware = pinoHttp({

  logger,

  genReqId: function (req) {

    const id = uuidv4();

    req.id = id;

    return id;
  },

  customSuccessMessage: function (
    req,
    res,
  ) {

    return `${req.method} ${req.url} completed`;
  },

  customErrorMessage: function (
    req,
    res,
    error,
  ) {

    return `${req.method} ${req.url} failed`;
  },
});

export default loggerMiddleware;