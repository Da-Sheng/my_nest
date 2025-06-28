import serverless from 'serverless-http';
import { createNestApp } from './main';

let cachedServer: any;

const bootstrapServer = async () => {
  if (!cachedServer) {
    const expressApp = await createNestApp();
    cachedServer = serverless(expressApp);
  }
  return cachedServer;
};

export const handler = async (event: any, context: any) => {
  const server = await bootstrapServer();
  return server(event, context);
};