let endpoint = "swapi-graphql.netlify.app/.netlify/functions/index"
// https://swapi-graphql.netlify.app/.netlify/functions/index


let httpLink = ApolloClient.Link.HttpLink.make(~uri=_ => "https://" ++ endpoint, ())
let cache = ApolloClient.Cache.InMemoryCache.make()
let client = {
  open ApolloClient
  make(
    ~cache,
    ~connectToDevTools=true,
    ~defaultOptions=DefaultOptions.make(
      ~mutate=DefaultMutateOptions.make(~awaitRefetchQueries=true, ~errorPolicy=All, ()),
      ~query=DefaultQueryOptions.make(~errorPolicy=All, ()),
      ~watchQuery=DefaultWatchQueryOptions.make(~errorPolicy=All, ()),
      (),
    ),
    ~link=httpLink,
    (),
  )
}
