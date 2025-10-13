import { tool as createTool } from 'ai';
import { z } from 'zod';

export const weatherTool = createTool({
  description: 'Display the weather for a location',
  inputSchema: z.object({
    location: z.string().describe('The location to get the weather for'),
  }),
  execute: async function ({ location }) {
    await new Promise(resolve => setTimeout(resolve, 2000));
    return { weather: 'Sunny', temperature: 75, location };
  },
});

export const stockTool = createTool({
  description: 'Get price for a stock',
  inputSchema: z.object({
    symbol: z.string().describe('The stock symbol to get the price for'),
  }),
  execute: async function ({ symbol }) {
    // Simulated API call
    await new Promise(resolve => setTimeout(resolve, 2000));
    return { symbol, price: 150 };
  },
});

export const sendTokenTool = createTool({
  description: 'Send STX or fungible tokens on the Stacks blockchain to another address. Use this when the user wants to send, transfer, or pay tokens (STX, USDA, sBTC, WELSH, etc.) to someone.',
  inputSchema: z.object({
    token: z.string().optional().describe('The token to send. Can be "STX" for Stacks tokens, or token symbol like "USDA", "sBTC", "WELSH". If not specified, defaults to STX.'),
    amount: z.string().optional().describe('The amount of tokens to send (e.g., "1", "0.5", "100")'),
    recipient: z.string().optional().describe('The recipient Stacks address (starts with SP or ST)'),
    memo: z.string().optional().describe('Optional memo/note for the transfer'),
    contractAddress: z.string().optional().describe('Full contract address for the token (e.g., "SP3K8BC0PPEVCV7NZ6QSRWPQ2JE9E5B6N3PA0KBR9.token-name")'),
  }),
  execute: async function ({ token, amount, recipient, memo, contractAddress }) {
    // Return the extracted data - the UI component will handle the actual transaction
    return {
      token: token || 'STX',
      amount: amount || '',
      recipient: recipient || '',
      memo: memo || '',
      contractAddress: contractAddress || '',
    };
  },
});

export const tools = {
  displayWeather: weatherTool,
  getStockPrice: stockTool,
  sendToken: sendTokenTool,
};