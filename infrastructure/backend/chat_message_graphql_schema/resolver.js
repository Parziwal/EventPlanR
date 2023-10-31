import { util } from '@aws-appsync/utils';

export function request(ctx) {
  return {
    operation: "Invoke",
    payload: { Field: ctx.info.fieldName, Arguments: ctx.args,  UserId: ctx.identity.username },
  };
}

export function response(ctx) {
  return ctx.result;
}