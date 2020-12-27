import { ApolloClient, HttpLink, InMemoryCache } from '@apollo/client';
// import { setContext } from '@apollo/link-context';

// see: https://github.com/graphql/swapi-graphql
const GRAPHQL_API_URL = 'https://swapi-graphql.netlify.app/.netlify/functions/index';

/*
uncomment the code below in case you are using a GraphQL API that requires some form of
authentication. asyncAuthLink will run every time your request is made and use the token
you provide while making the request.

module Apollo = {
  include ApolloClient.Bindings;
};
let token = "";
let headers = {"Authorization": token};
let asyncAuthLink =
  Apollo.Client.Link.Context.setContext(
    ~uri=_ => "http://" ++ graphqlEndpoint,
    ~headers=Obj.magic(headers),
    (),
  );
let contextLink = Apollo.Client.Link.Context.setContext(...);
let authLink = ApolloClient.Link.ContextLink.makeAsync((~operation as _, ~prevContext as ctx) =>
  UserToken.getUserToken()->Js.Promise.then_(token =>
    switch token->Js.Nullable.toOption {
    | None =>
      UserToken.getTempUserToken()->Js.Promise.then_(
        token => Js.Promise.resolve(Js.Nullable.toOption(token)),
        _,
      )

    | Some(token) => Js.Promise.resolve(Some(token))
    }
  , _)->Js.Promise.then_(x =>
    switch x {
    | None => Js.Promise.resolve(Js.Json.null)
    | Some(token) =>
      Js.Promise.resolve(
        %raw(
          ` (context, token) => ({
                headers: {
                  ...ctx.headers,
                  authorization: \`Bearer \${token}\`
                }
              }) `
        )(ctx, token),
      )
    }
  , _)
)
const TOKEN = '';
const asyncAuthLink = setContext(async () => {
  return {
    headers: {
      Authorization: TOKEN,
    },
  };
});

*/

const httpLink = new HttpLink({
  uri: GRAPHQL_API_URL,
});

export const apolloClient = new ApolloClient({
  cache: new InMemoryCache(),
  link: httpLink,
  // link: asyncAuthLink.concat(httpLink),
});
